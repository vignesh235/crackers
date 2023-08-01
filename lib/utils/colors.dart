import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xff232323);
  static Color scaffoldBackgroundColor = const Color(0xFFfcfffd);
  static Color textcolour = const Color(0xff53b467);
}

abstract class ThemeText {
  static TextStyle progressHeader = TextStyle(
      color: AppColors.scaffoldBackgroundColor,
      fontSize: 40,
      height: 0.5,
      fontWeight: FontWeight.w600);

  static const TextStyle progressBody = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 10,
      height: 0.5,
      fontWeight: FontWeight.w400);

  static const TextStyle progressFooter = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w600);
}

double finaltotalamount_ = 0.0;
int totalqty_ = 1;
List customerList = [];
TextEditingController customercontroller = TextEditingController();
