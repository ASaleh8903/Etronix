import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
    // primarySwatch: AppColors.background,
    // primaryColor: defaultColor,
    //scaffoldBackgroundColor: Color(0xFF1E1E2C) ,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF191A1F),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: Color(0xFF191A1F),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      // selectedItemColor: defaultColor,
      unselectedItemColor: Colors.white,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    fontFamily: 'Jannah',
    primaryTextTheme: TextTheme(bodySmall: TextStyle(color: Colors.white)),
    iconTheme: IconThemeData(color: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: HexColor('222E34'),
        border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    cardColor: HexColor('1B262C'));

ThemeData lightTheme = ThemeData(
  cardColor: Colors.white,
  // primarySwatch: defaultColor,
  // primaryColor: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    // selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 14.0,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah',
  primaryTextTheme: TextTheme(bodySmall: TextStyle(color: Colors.white)),
  iconTheme: IconThemeData(color: Colors.black),
  inputDecorationTheme: InputDecorationTheme(
      // fillColor: defaultColor,
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
);
