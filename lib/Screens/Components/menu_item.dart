import 'package:flutter/material.dart';
import 'package:in8_spa/Screens/Components/responsiveLayout.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Function press;
  const MenuItem({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     if (ResponsiveLayout.isLargeScreen(context))
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
    if (ResponsiveLayout.isMediumScreen(context))
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 15.0),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
          ),
        ),
      ),
    );
    else
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 20.0),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
