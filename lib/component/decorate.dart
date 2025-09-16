import 'package:flutter/material.dart';
import 'package:slokas/component/textstyle.dart';

class Dec {
  static Widget head(String txt, String ttl, bool drk) {
    debugPrint(txt);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: drk ? Colors.black87 : Colors.white70,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Text(
            txt,
            style: StyTxt.h5(dk: drk),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: drk ? Colors.black87 : Colors.white70,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Text(
            ttl,
            style: StyTxt.h4(dk: drk),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  static Widget name(String txt, bool drk) {
    return Container(
      decoration: BoxDecoration(
        color: drk ? Colors.black12 : Colors.white24,
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
        color: drk ? Colors.black12 : Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      child: Text(
        txt,
        style: StyTxt.h6(dk: drk),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget bdyTx(String txt, bool drk) {
    return Container(
      // decoration: BoxDecoration(
      //   color: drk?Colors.black12: Colors.white70,
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

  static Widget word(String txt, bool drk) {
    return Text(txt, style: StyTxt.h6(dk: drk));
  }

  static Widget wordMean(String txt, bool drk) {
    return Text(
      txt,
      style: StyTxt.txt(dk: drk),
      textAlign: TextAlign.right,
    );
  }
}
