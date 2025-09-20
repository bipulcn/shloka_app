import 'package:flutter/material.dart';
import 'package:slokas/const/colors.dart';
import 'dart:math' as math;

class Decor {
  Widget rBox(Widget child, bool thm, {Color clr = Colors.lightBlueAccent}) =>
      Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/border-b.png'),
            fit: BoxFit.none,
            alignment: AlignmentGeometry.xy(-15, 1),
          ),
          color: thm ? Clr.hc01(.6).withAlpha(50) : Clr.cl04.withAlpha(50),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            // BoxShadow(
            //   offset: Offset(1, 5),
            //   color: Colors.black.withAlpha(100),
            //   spreadRadius: -12,
            //   blurRadius: 20,
            // ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'assets/imgs/border.png',
                fit: BoxFit.contain,
                alignment: AlignmentGeometry.xy(-10, 0),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: child,
            ),
          ],
        ),
      );

  static Widget line(bool thm) => Container(
    height: 22,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          thm ? 'assets/imgs/linel.png' : 'assets/imgs/lined.png',
        ),
        fit: BoxFit.contain,
      ),
    ),
  );
  static Widget lineR(bool thm) => Transform.rotate(
    angle: math.pi,
    child: Container(
      height: 22,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            thm ? 'assets/imgs/linel.png' : 'assets/imgs/lined.png',
          ),
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
