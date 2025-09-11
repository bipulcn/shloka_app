import 'package:flutter/material.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';
import 'package:slokas/data/get_shlokas.dart';
import 'package:slokas/data/models/shlokas.dart';

class GitaShloka extends StatefulWidget {
  const GitaShloka({super.key});

  @override
  State<GitaShloka> createState() => _GitaShlokaState();
}

class _GitaShlokaState extends State<GitaShloka> {
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
