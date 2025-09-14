import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';
import 'package:slokas/data/get_shlokas.dart';
import 'package:slokas/data/models/shlokas.dart';

class Ramayana extends StatefulWidget {
  const Ramayana({super.key});

  @override
  State<Ramayana> createState() => _RamayanaState();
}

class _RamayanaState extends State<Ramayana> {
  Future<List<ShlokaModel>>? slk;
  final GetShloka _repo = GetShloka();
  Map<int, int> lang = {};
  Map<int, int> mean = {};
  bool dark = true;
  Random rand = Random();
  int r_num = 0;
  @override
  void initState() {
    super.initState();
    slk = _repo.getShlokaByCat('ramayana');
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
    r_num = rand.nextInt(bgImg.length);
  }

  List<String> bgImg = [
    'assets/imgs/om_01.jpg',
    'assets/imgs/om_02.jpg',
    'assets/imgs/om_03.jpg',
    'assets/imgs/om_04.jpg',
    'assets/imgs/om_05.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark ? Clr.dPri : Clr.lPri,
      // appBar: AppBar(title: Text("This is app bar")),
      body: SafeArea(
        child: FutureBuilder<List<ShlokaModel>>(
          future: slk,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No words found"));
            } else {
              final words = snapshot.data!;
              return PageView.builder(
                itemCount: words.length,
                itemBuilder: (context, index) {
                  final word = words[index];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 150),
                        Image.asset('assets/imgs/man.png', width: 50),
                        // Cards.crd4(word.id.toString(), tx: word.name),
                        // Center(child: Cards.crd5(word.sanskrit)),
                        // Cards.crd6(word.bengali),
                        // Cards.crd6(word.english),
                        // Cards.flipText(word.sanskrit, word.bengali),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              lang[index] = lang[index] == 0 ? 1 : 0;
                            });
                          },
                          child: Dec.impTx(
                            lang[index] == 1 ? word.bengali : word.sanskrit,
                            dark,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              mean[index] = mean[index] == 0 ? 1 : 0;
                            });
                          },
                          child: Dec.bdyTx(
                            mean[index] == 1 ? word.bng_mean : word.eng_mean,
                            dark,
                          ),
                        ),
                      ],
                      // trailing: word.learnt
                      //     ? const Icon(Icons.check, color: Colors.green)
                      //     : const Icon(Icons.school_outlined),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingBtn(),
    );
  }
}
