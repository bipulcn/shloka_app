import 'package:flutter/material.dart';
import 'package:slokas/component/textstyle.dart';

class Cards {
  static Widget simple(Widget cont, Color clr1) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: clr1.withAlpha(21),
      elevation: 0.0,
      // shadowColor: Colors.black.withAlpha(200),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black12),
      ),
      child: cont,
    );
  }

  static Widget lines(String tx1, String tx2, TextStyle st, TextStyle st1) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: RichText(
        text: TextSpan(
          style: st,
          children: [
            TextSpan(text: "$tx1  ", style: st),
            TextSpan(text: tx2, style: st1),
          ],
        ),
      ),
    );
  }

  static Widget flipText(String tx1, String tx2) {
    bool change = false;
    return Container(
      child: TextButton(
        onPressed: () {
          change = change == false ? true : false;
        },
        child: Text(change == true ? tx2 : tx1, style: StyTxt.h6()),
      ),
    );
  }

  static Widget bigTitle(String tx1, {String tx = ''}) => simple(
    lines(tx1, tx, StyTxt.h1(dk: true), StyTxt.h2(dk: true)),
    Colors.orangeAccent,
  );
  static Widget crd1(String tx1, {String tx = ''}) => simple(
    lines(tx1, tx, StyTxt.h1(dk: true), StyTxt.h2(dk: true)),
    Colors.orangeAccent,
  );
  static Widget crd2(String tx1, {String tx = ''}) => simple(
    lines(tx1, tx, StyTxt.h2(dk: true), StyTxt.h3(dk: true)),
    Colors.green,
  );
  static Widget crd3(String tx1, {String tx = ''}) => simple(
    lines(tx1, tx, StyTxt.h3(dk: true), StyTxt.h4(dk: true)),
    Colors.orange,
  );
  static Widget crd4(String tx1, {String tx = ''}) => simple(
    lines(tx1, tx, StyTxt.h4(dk: true), StyTxt.h5(dk: true)),
    Colors.cyanAccent,
  );
  static Widget crd5(String tx1, {String tx = ''}) => simple(
    lines(tx1, tx, StyTxt.h5(dk: true), StyTxt.h6(dk: true)),
    Colors.lightBlueAccent,
  );
  static Widget crd6(String tx1, {String tx = ''}) => simple(
    lines(tx1, tx, StyTxt.h6(dk: true), StyTxt.txt(dk: true)),
    Colors.lightGreen,
  );
  static Widget crd7(String tx1, {String tx = ''}) => simple(
    lines(tx1, tx, StyTxt.txt(dk: true), StyTxt.txt(dk: true)),
    Colors.blueGrey,
  );

  // static Widget title(String tx1) =>
}
