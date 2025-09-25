import 'package:flutter/material.dart';

class StyTxt {
  static TextStyle h1({bool dk = true}) => TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w100,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h2({bool dk = true}) => TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w100,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h3({bool dk = true}) => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w100,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h4({bool dk = true}) => TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w300,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h5({bool dk = true}) => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h6({bool dk = true}) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle word({bool dk = true}) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: dk == true ? Colors.orange : Colors.teal,
  );
  static TextStyle txt({bool dk = true}) =>
      TextStyle(fontSize: 16, color: dk == true ? Colors.white : Colors.black);
  static TextStyle shlok({bool dk = true, double siz = 0}) => TextStyle(
    fontFamily: "Karma",
    fontWeight: FontWeight.w500,
    fontSize: 18 + siz * 2,
    color: dk == true ? Colors.white : Colors.black,
  );
}
