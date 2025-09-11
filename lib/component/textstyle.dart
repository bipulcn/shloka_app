import 'package:flutter/material.dart';

class StyTxt {
  static TextStyle h1({bool dk = true}) => TextStyle(
    fontSize: 66,
    fontWeight: FontWeight.w100,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h2({bool dk = true}) => TextStyle(
    fontSize: 54,
    fontWeight: FontWeight.w100,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h3({bool dk = true}) => TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.w100,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h4({bool dk = true}) => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w300,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h5({bool dk = true}) => TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w400,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle h6({bool dk = true}) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: dk == true ? Colors.white : Colors.black,
  );
  static TextStyle txt({bool dk = true}) =>
      TextStyle(fontSize: 18, color: dk == true ? Colors.white : Colors.black);
}
