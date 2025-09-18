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
        style: StyTxt.shlok(dk: drk),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget word(String txt, bool drk) {
    return Text(txt, style: StyTxt.word(dk: drk));
  }

  static TextSpan wordMean(String txt, bool drk) {
    return TextSpan(
      text: txt,
      style: StyTxt.txt(dk: drk),
    );
  }

  static RichText test() {
    return RichText(
      text: TextSpan(
        text: 'Hello ', // Default style for this part
        style: TextStyle(
          fontSize: 20,
          color: Colors.red,
        ), // Inherit default app style
        children: <TextSpan>[
          TextSpan(
            text: 'bold',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 30,
            ), // Specific style for "bold"
          ),
          TextSpan(
            text: ' world!',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.red,
            ), // Specific style for "world!"
          ),
        ],
      ),
    );
  }
}
