import 'package:flutter/material.dart';
import 'package:in8_spa/Screens/Components/drawer.dart';
import 'package:in8_spa/Screens/Components/menu_item.dart';
import 'package:in8_spa/Screens/Components/responsiveLayout.dart';
import 'package:in8_spa/consts.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isLargeScreen(context))
      return Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 200),
                      child: Image.asset(
                        logoIn8,
                        alignment: Alignment.topCenter,
                        height: 25,
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Row(
                      children: [
                        MenuItem(
                          title: "cadastro",
                          press: () {},
                        ),
                        DividerBol(),
                        MenuItem(
                          title: "lista",
                          press: () {},
                        ),
                        DividerBol(),
                        MenuItem(
                          title: "sobre mim",
                          press: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ]);
    if (ResponsiveLayout.isMediumScreen(context))
      return Container(
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Expanded(
                  child: Image.asset(
                    logoIn8,
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
          MobiMenu()
        ]),
      );
    else
      return Container(
        color: Colors.black87,
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Expanded(
                  child: Image.asset(
                    logoIn8,
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
          MobiMenu()
        ]),
      );
  }
}

class DividerBol extends StatelessWidget {
  const DividerBol({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
    );
  }
}
