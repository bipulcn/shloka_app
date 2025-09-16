import 'package:flutter/material.dart';

class Btn {
  static Widget tBtn(String txt, VoidCallback fun) {
    return TextButton(
      onPressed: fun,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          txt,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static Widget iBtn(IconData icn, VoidCallback fun) {
    return IconButton(
      onPressed: fun,
      icon: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Icon(icn, color: Colors.white),
      ),
    );
  }
}
