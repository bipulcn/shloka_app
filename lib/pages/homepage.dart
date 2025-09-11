import 'package:flutter/material.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr.lPri,
      // appBar: AppBar(title: Text("This is app bar")),
      body: SafeArea(child: Text("working")),
      floatingActionButton: FloatingBtn(),
    );
  }
}
