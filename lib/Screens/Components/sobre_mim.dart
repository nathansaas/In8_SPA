import 'package:flutter/material.dart';
import 'package:in8_spa/Screens/Components/responsiveLayout.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isLargeScreen(context))
    return Stack(
      children: [
        Image.asset("assets/imagens/rodape-desktop.jpg"),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fulano Beltrano de Oliveira da Silva",
                    style: TextStyle(
                      fontFamily: 'Roboto_Light',
                      color: Colors.white,
                      fontSize: 18
                      ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "fulanobos@gmail.com",
                    style: TextStyle(
                      fontFamily: 'Roboto_Light',
                      color: Colors.white,
                      fontSize: 18
                      ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "(31) 9 9666-1111",
                    style: TextStyle(
                      fontFamily: 'Roboto_Light',
                      color: Colors.white,
                      fontSize: 18
                      ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Faculdade de Belo Horizonte",
                    style: TextStyle(
                      fontFamily: 'Roboto_Light',
                      color: Colors.white,
                      fontSize: 18
                      ),
                  )
                ],
              ),
            ),
          ],
        ),
        
    ],
    );
    if (ResponsiveLayout.isMediumScreen(context))
    return Stack(
      children: [
        Image.asset("assets/imagens/rodape-desktop.jpg"),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fulano Beltrano de Oliveira da Silva",
                    style: TextStyle(
                      fontFamily: 'Roboto_Light',
                      color: Colors.white,
                      fontSize: 18
                      ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "fulanobos@gmail.com",
                    style: TextStyle(
                      fontFamily: 'Roboto_Light',
                      color: Colors.white,
                      fontSize: 18
                      ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "(31) 9 9666-1111",
                    style: TextStyle(
                      fontFamily: 'Roboto_Light',
                      color: Colors.white,
                      fontSize: 18
                      ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Faculdade de Belo Horizonte",
                    style: TextStyle(
                      fontFamily: 'Roboto_Light',
                      color: Colors.white,
                      fontSize: 18
                      ),
                  )
                ],
              ),
            ),
          ],
        ),
        
    ],
    );
    else
    return Stack(
      children: [
        Image.asset("assets/imagens/rodape-mobile.jpg"),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fulano Beltrano de Oliveira da Silva",
                      style: TextStyle(
                        fontFamily: 'Roboto_Light',
                        color: Colors.white,
                        fontSize: 20
                        ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "fulanobos@gmail.com",
                      style: TextStyle(
                        fontFamily: 'Roboto_Light',
                        color: Colors.white,
                        fontSize: 20
                        ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "(31) 9 9666-1111",
                      style: TextStyle(
                        fontFamily: 'Roboto_Light',
                        color: Colors.white,
                        fontSize: 20
                        ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Faculdade de Belo Horizonte",
                      style: TextStyle(
                        fontFamily: 'Roboto_Light',
                        color: Colors.white,
                        fontSize: 20
                        ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        
    ],
    );
  }
}