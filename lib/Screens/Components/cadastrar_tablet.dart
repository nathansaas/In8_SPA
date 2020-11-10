import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart';

class CadastrarTablet extends StatefulWidget {
  @override
  _CadastrarTabletState createState() => _CadastrarTabletState();
}

class _CadastrarTabletState extends State<CadastrarTablet> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nascimentoController = TextEditingController();
  final _telefoneController = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});
  var maskFormatterBirth = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  bool showErrorName = false;
  bool showErrorEmail = false;
  bool showErrorBirth = false;
  bool showErrorPhone = false;

  List _usersData = [];

  static final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool validateEmail(String email) {
    final Iterable<Match> matches = _emailRegex.allMatches(email);
    final bool isValid = matches.isNotEmpty && email.isNotEmpty;

    return isValid;
  }

  static bool validateDate(String myDate) {
    try {
      String dateString =
          '${myDate.substring(6)}-${myDate.substring(3, 5)}-${myDate.substring(0, 2)}';
      DateTime date = DateTime.parse(dateString);
      DateTime dateNow = DateTime.now();
      final difference = date.difference(dateNow).inDays;
      String validate =
          '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      return validate == dateString && difference < 0;
    } catch (error) {
      return false;
    }
  }

  bool isNameValid() => _nameController.text.trim().length > 3;
  bool isEmailValid() => validateEmail(_emailController.text);
  bool isBirthDateValid() => validateDate(_nascimentoController.text);
  bool isPhoneValid() => _telefoneController.text.trim().length == 16;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();

    _readData().then((data) {
      setState(() {
        _usersData = json.decode(data);
      });
    });
  }

  void _addToDo() {
    if (isNameValid() &&
        isEmailValid() &&
        isBirthDateValid() &&
        isPhoneValid()) {
      setState(() {
        Map<String, dynamic> newToDo = Map();
        newToDo["name"] = _nameController.text;
        _nameController.text = "";
        newToDo["email"] = _emailController.text;
        _emailController.text = "";
        newToDo["birthDate"] = _nascimentoController.text;
        _nascimentoController.text = "";
        newToDo["phone"] = _telefoneController.text;
        _telefoneController.text = "";
        _usersData.add(newToDo);
        _saveData();
        showErrorName = false;
        showErrorEmail = false;
        showErrorBirth = false;
        showErrorPhone = false;
      });
    } else {
      setState(() {
        showErrorName = true;
        showErrorEmail = true;
        showErrorBirth = true;
        showErrorPhone = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color(0xFF29ABE2),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 0.0),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cadastro".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: 'Helvetica'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _nameController,
                          onChanged: (text) {
                            setState(() {
                              showErrorName = false;
                            });
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              errorText: showErrorName && !isNameValid()
                                  ? "Nome Inválido"
                                  : null,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: "Nome",
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                              )),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 21.0, fontFamily: 'Helvetica_Condensed',),
                        ),
                        TextFormField(
                          onChanged: (text) {
                            setState(() {
                              showErrorEmail = false;
                            });
                          },
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              errorText: showErrorEmail && !isEmailValid()
                                  ? "E-mail Inválido"
                                  : null,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: "E-mail",
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                              )),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 21.0, fontFamily: 'Helvetica_Condensed',),
                        ),
                        TextFormField(
                          onChanged: (text) {
                            setState(() {
                              showErrorBirth = false;
                            });
                          },
                          inputFormatters: [maskFormatterBirth],
                          controller: _nascimentoController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              errorText: showErrorBirth && !isBirthDateValid()
                                  ? "Data de Nacimento Inválida"
                                  : null,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: "Nascimento",
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                              )),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 21.0, fontFamily: 'Helvetica_Condensed',),
                        ),
                        TextFormField(
                          onChanged: (text) {
                            setState(() {
                              showErrorPhone = false;
                            });
                          },
                          inputFormatters: [maskFormatter],
                          controller: _telefoneController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              errorText: showErrorPhone && !isPhoneValid()
                                  ? "Número de telefone Inválido"
                                  : null,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: "Telefone",
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                              )),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 21.0, fontFamily: 'Helvetica_Condensed',),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60.0, bottom: 10.0),
                          child: Container(
                            height: 60.0,
                            child: RaisedButton(
                              onPressed: _addToDo,
                              child: Text(
                                "Cadastrar".toUpperCase(),
                                style: TextStyle(
                                    color: Color(0XFF29ABE2),
                                    fontSize: 35.0,
                                    fontFamily: 'Helvetica'),
                              ),
                              color: Color(0XFF012D51),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Lista de Cadastro".toUpperCase(),
                      style: TextStyle(
                          color: Color(0xFF29ABE2),
                          fontSize: 40,
                          fontFamily: 'Helvetica'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              _usersData.isEmpty
                  ? Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ainda não há registros cadastrados!",
                            style: TextStyle(
                                fontFamily: 'Roboto', color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  : _userTable()
            ],
          ),
        )
      ],
    );
  }

  Widget _userTable() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        child: Column(children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
              child: Column(children: [
                Table(
                    border:
                    TableBorder(
                        bottom: BorderSide(
                            width: 1,
                            color: Color(0XFF29ABE2),
                            style: BorderStyle.solid),
                        verticalInside: BorderSide(
                            width: 1,
                            color: Color(0XFF29ABE2),
                            style: BorderStyle.solid)),
                    columnWidths: {
                      0: FlexColumnWidth(6),
                      1: FlexColumnWidth(8),
                      2: FlexColumnWidth(8),
                      3: FlexColumnWidth(8),
                      4: FlexColumnWidth(8),
                    },
                    children: [
                      TableRow(
                        children: [
                        TableCell(
                          child: Text('', textAlign: TextAlign.center),
                        ),
                        TableCell(
                            child: textCreatorTable("Nome")),
                        TableCell(
                         child: textCreatorTable("E-mail")),
                        TableCell(
                        child: textCreatorTable("Nascimento")),
                        TableCell(
                          child: textCreatorTable("Telefone")),
                      ]),
                    ]),
                Table(
                  border: TableBorder(
                        verticalInside: BorderSide(
                            width: 1,
                            color: Color(0XFF29ABE2),
                            style: BorderStyle.solid),
                        bottom: BorderSide(
                            width: 1,
                            color: Color(0XFF29ABE2),
                            style: BorderStyle.solid)),
                    columnWidths: {
                      0: FlexColumnWidth(6),
                      1: FlexColumnWidth(8),
                      2: FlexColumnWidth(8),
                      3: FlexColumnWidth(8),
                      4: FlexColumnWidth(8),
                    },
                    children: List.generate(
                  _usersData.length,
                  (index) => _tableItem(index),
                ))
              ]),

              //    dataTextStyle: TextStyle(color: Color(0XFF012D51)),
              //   columns: [
              //     DataColumn(label: Text('')),
              //     DataColumn(label: Text('Nome'.toUpperCase(), style: TextStyle(color: Color(0xFF012D51)),)),
              //     DataColumn(label: Text('E-mail'.toUpperCase(), style: TextStyle(color: Color(0xFF012D51)),)),
              //     DataColumn(label: Text('Nascimento'.toUpperCase(), style: TextStyle(color: Color(0xFF012D51)),)),
              //     DataColumn(label: Text('Telefone'.toUpperCase(), style: TextStyle(color: Color(0xFF012D51)),)),
              //   ],
              //   rows: List.generate(
              //   _usersData.length,
              //   (index) => _tableItem(index),
              // )
            ),
          )
        ]),
      );

  Widget textCreatorTable(String texto) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
                          texto.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF012D51),
                          fontFamily: 'Roboto'),
                        ),
    );
  }
  TableRow _tableItem(int index) {
    return TableRow(children: [
      _textCreatorData('${index + 1}'),
      _textCreatorData(_usersData[index]['name']),
      _textCreatorData(_usersData[index]['email']),
      _textCreatorData(_usersData[index]['birthDate']),
      _textCreatorData(_usersData[index]['phone']),
    ]);
  }
Widget _textCreatorData(String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(
                          data.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF808080),
                          fontFamily: 'Helvetica'),
                        ),
    );
  }
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_usersData);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
