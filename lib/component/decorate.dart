import 'package:flutter/material.dart';
import 'package:slokas/component/textstyle.dart';

class Dec {
  static Widget head(String txt, bool drk) {
    debugPrint(txt);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            txt,
            style: StyTxt.h1(dk: false),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  static Widget name(String txt, bool drk) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      child: Text(
        txt,
        style: StyTxt.h5(dk: drk),
        textAlign: TextAlign.center,
      ),
    );
  }

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
