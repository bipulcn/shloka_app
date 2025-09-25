import 'package:flutter/material.dart';
import 'package:slokas/const/colors.dart';
import 'package:slokas/data/alphabet.dart';
import 'package:slokas/data/get_tracks.dart';
import 'package:slokas/data/models/tracks.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/subpage/basic_alphabet.dart';

class SansKritPhonetics extends StatefulWidget {
  const SansKritPhonetics({super.key});

  @override
  State<SansKritPhonetics> createState() => _SansKritPhoneticsState();
}

class _SansKritPhoneticsState extends State<SansKritPhonetics> {
  bool dark = true;

  void gPage() async {
    List<Track> th = await GetTracks().rdByKind('theme');
    if (th.isNotEmpty) {
      dark = th.first.main == "dark" ? true : false;
    }
    setState(() {});
  }

  @override
  void initState() {
    gPage();
    super.initState();
  }

  int _selIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark ? Clr.dPri : Clr.lPri,
      body: SafeArea(
        child: SingleChildScrollView(
          child: <Widget>[
            Bornas(dark: dark),
            Akars(dark: dark),
            AllAkars(dark: dark),
            Combined(dark: dark),
          ].elementAt(_selIndex),
        ),
      ),
      floatingActionButton: FloatingBtn(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text("क", style: btxSty(dark)),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Text("का", style: btxSty(dark)),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Text("खा", style: btxSty(dark)),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Text("क्ख", style: btxSty(dark)),
            label: '',
            backgroundColor: Colors.transparent,
          ),
        ],
        currentIndex: _selIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  TextStyle btxSty(bool dark) => TextStyle(color: dark ? Colors.white : Colors.black);

  // double _getFontSize(String text) {
  //   if (text.length <= 2) return 14;
  //   if (text.length <= 4) return 12;
  //   return 10;
  // }

  // FontWeight _getFontWeight(int rowIndex, String text) {
  //   if (rowIndex == 0) return FontWeight.bold;
  //   if (text.contains('☑') || text.contains('☆')) return FontWeight.bold;
  //   return FontWeight.normal;
  // }

  // Color _getTextColor(String text) {
  //   if (text.contains('☑')) return Colors.green;
  //   if (text.contains('☆')) return Colors.blue;
  //   if (text.isEmpty) return Colors.grey[400]!;
  //   return Colors.black;
  // }
}
