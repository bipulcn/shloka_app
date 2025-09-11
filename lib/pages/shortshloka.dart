import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';
import 'package:slokas/data/get_shlokas.dart';
import 'package:slokas/data/models/shlokas.dart';

class SingleShloka extends StatefulWidget {
  const SingleShloka({super.key});

  @override
  State<SingleShloka> createState() => _SingleShlokaState();
}

class _SingleShlokaState extends State<SingleShloka> {
  Future<List<ShlokaModel>>? slk;
  final GetShloka _repo = GetShloka();
  int r_num = 0;
  bool dark = true;
  Map<int, int> lang = {};
  Map<int, int> mean = {};
  Random rand = Random();
  @override
  void initState() {
    super.initState();
    slk = _repo.getShlokaByCat('short');
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
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                bgImg[r_num],
                              ), // Or NetworkImage('your_image_url')
                              fit: BoxFit
                                  .cover, // This makes the image cover the container
                            ),
                          ),
                        ),
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
                            mean[index] == 1 ? word.meaning : word.english,
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
