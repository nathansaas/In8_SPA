import 'package:flutter/material.dart';
import 'package:in8_spa/Screens/Components/customAppBar.dart';
import 'package:in8_spa/Screens/body.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
              children: [
                Body(),
                CustomAppBar(),
              ],
            ),
      );
  }
}