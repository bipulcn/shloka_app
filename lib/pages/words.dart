import 'package:flutter/material.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/component/textstyle.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';
import 'package:slokas/data/get_shlokas.dart';
import 'package:slokas/data/models/shlokas.dart';

class WordMeaning extends StatefulWidget {
  const WordMeaning({super.key});

  @override
  State<WordMeaning> createState() => _WordMeaningState();
}

class _WordMeaningState extends State<WordMeaning> {
  Future<List<ShlokaModel>>? slk;
  final GetShloka _repo = GetShloka();
  Map<int, int> lang = {};
  Map<int, int> mean = {};
  @override
  void initState() {
    super.initState();
    slk = _repo.getShlokaByCat('gita');
    int ind = 0;
    slk?.then((SList) {
      if (SList != null) {
        for (var itm in SList) {
          lang[ind] = 0;
          mean[ind] = 0;
          ind++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr.lPri,
      // appBar: AppBar(title: Text("This is app bar")),
      body: SafeArea(child: Text("Words will be here", style: StyTxt.h1())),
      floatingActionButton: FloatingBtn(),
    );
  }
}
