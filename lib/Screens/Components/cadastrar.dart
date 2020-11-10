import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart';

class Cadastrar extends StatefulWidget {
  @override
  _CadastrarState createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  int _userIndex = 0;

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
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

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
                      "Lista de\n Cadastro".toUpperCase(),
                      style: TextStyle(
                          color: Color(0xFF29ABE2),
                          fontSize: 40,
                          fontFamily: 'Helvetica'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              _usersData.isEmpty ? Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ainda não há registros cadastrados!",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.red
                      ),
                    ),
                  ],
                ),
                ) : _userGrid()
            ],
          ),
        )
      ],
    );
  }

  Widget _userGrid() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                _usersData.length,
                (index) => _tabItem(index),
              )),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0XFF29abe2)),
              ),
              padding: EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  _handleListItem('NOME', _usersData[_userIndex]['name']),
                  _handleListItem('E-MAIL', _usersData[_userIndex]['email']),
                  _handleListItem('NASC.', _usersData[_userIndex]['birthDate']),
                  _handleListItem('TEL.', _usersData[_userIndex]['phone']),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _tabItem(int index) => GestureDetector(
        onTap: () {
          setState(() => _userIndex = index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 37,
            vertical: 10,
          ),
          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                  color: isSelected(index)
                      ? Color(0XFF29abe2)
                      : Color(0XFF808080)),
              left: BorderSide(
                  color: isSelected(index)
                      ? Color(0XFF29abe2)
                      : Color(0XFF808080)),
              right: BorderSide(
                  color: isSelected(index)
                      ? Color(0XFF29abe2)
                      : Color(0XFF808080)),
            ),
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: isSelected(index) ? Color(0XFF29abe2) : Color(0XFF808080),
              fontFamily: 'Roboto Light'
            ),
          ),
        ),
      );

  bool isSelected(int item) => item == _userIndex;

  Widget _handleListItem(String title, String data) => Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0XFF29abe2)))),
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        padding: EdgeInsets.only(bottom: 4.0),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(color: Color(0XFF012d51), fontFamily: 'Roboto'),
            ),
            Expanded(
                child: Text(data,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.black, fontFamily: 'Helvetica_Condensed'),
                    overflow: TextOverflow.ellipsis)),
          ],
        ),
      );

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
