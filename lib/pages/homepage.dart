import 'package:flutter/material.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool dark = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark ? Clr.dPri : Clr.lPri,
      // appBar: AppBar(title: Text("This is app bar")),
      body: SafeArea(child: Dec.impTx("working", dark)),
      floatingActionButton: FloatingBtn(),
    );
  }
}
