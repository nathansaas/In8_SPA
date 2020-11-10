import 'package:flutter/material.dart';
import 'package:in8_spa/Screens/Components/menu_item.dart';
import 'package:in8_spa/Screens/Components/responsiveLayout.dart';
import 'package:in8_spa/consts.dart';

class MobiMenu extends StatefulWidget {
  @override
  _MobiMenuState createState() => _MobiMenuState();
}

class _MobiMenuState extends State<MobiMenu> {
  bool _isVisible = false;

  void showDrawer() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!ResponsiveLayout.isSmallScreen(context))
    return Stack(children: [
      AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            height: _isVisible ? size.height : 0.0,
            width: _isVisible ? size.width : 0.0,
            color: Colors.white.withOpacity(0.5),
          )),
      Container(
        margin: EdgeInsets.fromLTRB(50.0, 35.0, 0.0, 0.0),
        child: IconButton(
          icon: Image.asset(
            iconMenu,
            height: 23,
          ),
          onPressed: showDrawer,
        ),
      ),
      AnimatedPositioned(
        duration: Duration(milliseconds: 200),
        top: _isVisible ? 0 : -400,
        child: Container(
          height: 300,
          width: 273,
          decoration: BoxDecoration(color: Color(0xFF29ABE2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(50.0, 30.0, 0.0, 60.0),
                  child: IconButton(
                    icon: Image.asset(
                      iconMenuAberto,
                      height: 30,
                    ),
                    onPressed: showDrawer,
                  ),
                ),
              ]),
              Row(
                children: [
                  MenuItem(
                    title: "lista",
                    press: showDrawer,
                  ),
                ],
              ),
              Row(
                children: [
                  MenuItem(
                    title: "sobre mim",
                    press: showDrawer,
                  ),
                ],
              ),
              Row(
                children: [
                  MenuItem(
                    title: "cadastro",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ]);
    else 
    return Stack(children: [
      AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            height: _isVisible ? size.height : 0.0,
            width: _isVisible ? size.width : 0.0,
            color: Colors.white.withOpacity(0.1),
          )),
      Container(
        margin: EdgeInsets.fromLTRB(50.0, 35.0, 0.0, 0.0),
        child: IconButton(
          icon: Image.asset(
            iconMenu,
            height: 23,
          ),
          onPressed: showDrawer,
        ),
      ),
      AnimatedPositioned(
        duration: Duration(milliseconds: 200),
        top: _isVisible ? 0 : -400,
        child: Container(
          height: 340,
          width: 273,
          decoration: BoxDecoration(color: Color(0xFF29ABE2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 60.0),
                  child: IconButton(
                    icon: Image.asset(
                      iconMenuAberto,
                      height: 30,
                    ),
                    onPressed: showDrawer,
                  ),
                ),
              ]),
              Row(
                children: [
                  MenuItem(
                    title: "lista",
                    press: showDrawer,
                  ),
                ],
              ),
              Row(
                children: [
                  MenuItem(
                    title: "sobre mim",
                    press: showDrawer,
                  ),
                ],
              ),
              Row(
                children: [
                  MenuItem(
                    title: "cadastro",
                    press: showDrawer,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
