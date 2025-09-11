import 'package:flutter/material.dart';
import 'package:slokas/component/textstyle.dart';

class Dec {
  static Widget impTx(String txt, bool drk) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      child: Text(
        txt,
        style: StyTxt.h5(dk: drk),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget bdyTx(String txt, bool drk) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.black12,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      child: Text(
        txt,
        style: StyTxt.txt(dk: drk),
        textAlign: TextAlign.center,
      ),
    );
  }
}
