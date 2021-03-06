import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color darkGreyClr = Color(0xFF121212);
class MyTheme{
  static Color accent_color = Color.fromRGBO(30,27,86, 1);
  static Color red_accent_color = Color.fromRGBO(227, 0, 13, 1);
  static Color soft_accent_color = Color.fromRGBO(240, 79, 99, 1);
  static Color splash_screen_color = Color.fromRGBO(30,27,86, 1);
  static Color whatsapp_color = Color.fromRGBO(7, 94, 84, 1);
  static Color call_icon = Color.fromRGBO(24, 172, 182, 1);
  static Color bg_color = Color.fromARGB(255, 240, 240, 240);

  static Color white = Color.fromRGBO(255,255,255, 1);
  static Color light_grey = Color.fromRGBO(239,239,239, 1);
  static Color dark_grey = Color.fromRGBO(112,112,112, 1);
  static Color medium_grey = Color.fromRGBO(132,132,132, 1);
  static Color grey_153 = Color.fromRGBO(153,153,153, 1);
  static Color font_grey = Color.fromRGBO(73,73,73, 1);
  static Color textfield_grey = Color.fromRGBO(209,209,209, 1);
  static Color golden = Color.fromRGBO(240, 79, 99, 1);
  static Color shimmer_base = Colors.grey.shade50;
  static Color shimmer_highlighted = Colors.grey.shade200;
  static Color black = Colors.black;

  //testing shimmer
  /*static Color shimmer_base = Colors.redAccent;
  static Color shimmer_highlighted = Colors.yellow;*/


TextStyle get subHeadingStyle{
    return GoogleFonts.lato(
        // ignore: prefer_const_constructors
        textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        )
    );
  }
TextStyle get HeadingStyle{
    return GoogleFonts.lato(
        // ignore: prefer_const_constructors
        textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        )
    );
  }
  TextStyle get titleStyle{
    return GoogleFonts.lato(
        // ignore: prefer_const_constructors
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: MyTheme.black
        )
    );
  }
    TextStyle get subtitleStyle{
    return GoogleFonts.lato(
        // ignore: prefer_const_constructors
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: MyTheme.black
        )
    );
  }
}
