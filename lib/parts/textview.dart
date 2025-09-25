import 'package:flutter/material.dart';
import 'package:slokas/component/buttons.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/const/colors.dart';

//ignore: must_be_immutable
class TextView extends StatefulWidget {
  String t1st;
  String t2nd;
  String t3rd;
  int lang;
  bool dark;
  double siz;
  int bgs;
  TextView({
    super.key,
    required this.t1st,
    required this.t2nd,
    required this.t3rd,
    required this.lang,
    required this.dark,
    required this.siz,
    required this.bgs,
  });

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  late int beng;
  void setInd(int num) {
    setState(() {
      debugPrint("On load value is ${widget.lang}");
      // widget.lang = num;
      beng = num;
    });
  }

  // @override
  void initState() {
    super.initState();
    debugPrint(widget.bgs.toString());
    // beng = widget.lang;
    if (widget.t2nd != "" && widget.lang == 1) {
      setInd(widget.lang);
    } else if (widget.t3rd != "" && widget.lang == 2) {
      // setInd(widget.lang);
    } else {
      setInd(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: widget.bgs == 1
            ? DecorationImage(
                image: AssetImage('assets/imgs/border-b.png'),
                fit: BoxFit.none,
                alignment: AlignmentGeometry.xy(-15, 1),
              )
            : null,
        color: widget.bgs == 1
            ? widget.dark
                  ? Clr.hc01(.6).withAlpha(50)
                  : Clr.hc04(0.8)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          widget.bgs == 1
              ? widget.dark
                    ? BoxShadow(color: Colors.transparent)
                    : BoxShadow(
                        offset: Offset(1, 5),
                        color: Colors.black.withAlpha(100),
                        spreadRadius: -12,
                        blurRadius: 20,
                      )
              : BoxShadow(color: Colors.transparent),
        ],
      ),
      child: Stack(
        children: [
          widget.bgs == 1
              ? Positioned(
                  child: Image.asset(
                    'assets/imgs/border.png',
                    fit: BoxFit.contain,
                    alignment: AlignmentGeometry.xy(-10, 0),
                  ),
                )
              : SizedBox(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(0),
                  child: Dec.bdyTx(
                    [widget.t1st, widget.t2nd, widget.t3rd][beng],
                    widget.dark,
                    widget.siz,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (widget.t2nd != "" || widget.t3rd != "")
                        ? Btn.tBtn("अ", () {
                            setInd(0);
                          })
                        : SizedBox(),
                    (widget.t2nd != "")
                        ? Btn.tBtn("অ", () {
                            setInd(1);
                          })
                        : SizedBox(),
                    (widget.t3rd != "")
                        ? Btn.tBtn("A", () {
                            setInd(2);
                          })
                        : SizedBox(),
                    Btn.tBtn("-", () {}),
                    Btn.tBtn("+", () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
