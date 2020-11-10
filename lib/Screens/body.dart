import 'package:flutter/material.dart';
import 'package:in8_spa/Screens/Components/cadastrar.dart';
import 'package:in8_spa/Screens/Components/cadastrar_tablet.dart';
import 'package:in8_spa/Screens/Components/cadastrar_web.dart';
import 'package:in8_spa/Screens/Components/responsiveLayout.dart';
import 'package:in8_spa/Screens/Components/sobre_mim.dart';
import 'package:in8_spa/Screens/Components/textpage.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isLargeScreen(context))
      return SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                      child: Stack(children: [
                    Image.asset("assets/imagens/index-image.jpg"),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(360.0, 220.0, 0.0, 0.0),
                      child: TextoPage(),
                    )
                  ])),
                  CadastrarWeb(),
                  Sobre()
                ],
              )
            ],
          ),
        ),
      );
    if (ResponsiveLayout.isMediumScreen(context))
      return SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(children: [
                    Image.asset("assets/imagens/index-image.jpg"),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(130.0, 120.0, 0.0, 0.0),
                      child: TextoPage(),
                    )
                  ]),
                  CadastrarTablet(),
                  Sobre()
                ],
              )
            ],
          ),
        ),
      );
    else
      return SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(children: [
                    Image.asset("assets/imagens/index-image-mobile.jpg"),
                    Container(
                      margin: EdgeInsets.only(top: 180.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextoPage(),
                        ],
                      ),
                    ),
                  ]),
                  Cadastrar(),
                  Sobre()
                ],
              )
            ],
          ),
        ),
      );
  }
}