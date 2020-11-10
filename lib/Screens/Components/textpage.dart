import 'package:flutter/material.dart';

class TextoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Estágio".toUpperCase(),
          style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontFamily: 'Helvetica',
              ),
        ),
        Text(
          "Prova de Seleção".toUpperCase(),
          style: TextStyle(
            fontSize: 34,
            fontFamily: 'Helvetica',
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}