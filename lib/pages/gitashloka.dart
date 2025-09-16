import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/data/get_tracks.dart';
import 'package:slokas/data/models/tracks.dart';
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
  int r_num = 0;
  bool dark = true;
  Map<int, int> lang = {};
  Map<int, int> mean = {};
  Random rand = Random();
  late PageController pageCon = PageController(initialPage: 0);
  double _currentSliderValue = 15;

  void gPage() async {
    List<Track> th = await GetTracks().rdByKind('theme');
    if (th.isNotEmpty) {
      dark = th.first.main == "dark" ? true : false;
    }
    List<Track> tk = await GetTracks().rdByKind('gita');
    debugPrint(tk.toString());
    if (tk.isNotEmpty) {
      pageCon = PageController(initialPage: tk.first.subs);
    } else {
      pageCon = PageController(initialPage: 0);
    }
    setState(() {});
  }

  void setPage(int page) async {
    await GetTracks().uKindTrack(
      Track(kinds: 'page', main: '/gita', subs: page),
    );
    await GetTracks().uKindTrack(Track(kinds: 'gita', main: '', subs: page));
  }

  Future<void> getPage(int num) async {
    final list = await slk;
    list?.forEach((obj) {
      if (obj.chapter == num) {
        debugPrint(obj.id.toString());
        setPage(obj.id ?? 0);
        pageCon.animateToPage(
          obj.id ?? 0, // Navigate to the second page (index 1)
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    slk = _repo.getShlokaByCat('gita');
    gPage();
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
  void dispose() {
    pageCon.dispose(); // Dispose of the controller when the widget is removed
    super.dispose();
  }

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
                controller: pageCon,
                onPageChanged: (value) => setPage(value),
                itemCount: words.length,
                itemBuilder: (context, index) {
                  final word = words[index];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                bgImg[index % bgImg.length],
                              ), // Or NetworkImage('your_image_url')
                              fit: BoxFit
                                  .cover, // This makes the image cover the container
                            ),
                          ),
                          padding: EdgeInsets.only(top: 140),
                          child: Dec.head(
                            "${word.chapter}:${word.serial}",
                            word.name.toString(),
                            dark,
                          ),
                        ),
                        // Dec.name(word.name.toString(), dark),
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
                        Dec.bdyTx(word.wordMeaning, dark),
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
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 10,
          child: SliderTheme(
            data: SliderThemeData(
              thumbColor: Colors.green,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: _currentSliderValue,
              min: 0,
              max: 18,
              divisions: 18,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                  getPage(value.toInt());
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
