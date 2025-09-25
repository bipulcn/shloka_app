import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slokas/component/buttons.dart';
import 'package:slokas/component/decoreate.dart';
import 'package:slokas/parts/bottombar.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/data/get_tracks.dart';
import 'package:slokas/data/models/tracks.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';
import 'package:slokas/data/get_shlokas.dart';
import 'package:slokas/data/models/shlokas.dart';
import 'package:slokas/parts/textview.dart';

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
  double _currentSliderValue = 1;
  int bang = 0;
  int lngW = 0;
  int numShl = 1;

  void gPage() async {
    List<Track> ln = await GetTracks().rdByKind('bengali');
    if (ln.isNotEmpty) {
      bang = ln.first.main == 'yes' ? 1 : 0;
    }
    List<Track> th = await GetTracks().rdByKind('theme');
    if (th.isNotEmpty) {
      dark = th.first.main == "dark" ? true : false;
    }
    List<Track> tk = await GetTracks().rdByKind('gita');
    // debugPrint(tk.toString());
    if (tk.isNotEmpty) {
      pageCon = PageController(initialPage: tk.first.subs);
    } else {
      pageCon = PageController(initialPage: 0);
    }
    setState(() {});
  }

  void setPage(int page) async {
    await GetTracks().uKindTrack(Track(kinds: 'page', main: '/gita', subs: page));
    await GetTracks().uKindTrack(Track(kinds: 'gita', main: '', subs: page));
  }

  Future<void> getPage(int num) async {
    // debugPrint(num.toString());
    final list = await slk;
    setPage(num);
    pageCon.animateToPage(num, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
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
        numShl = (ind / 3).toInt();
      }
    });
    r_num = rand.nextInt(bgImg.length);
  }

  List<String> bgImg = [
    'assets/imgs/om_06.jpg',
    'assets/imgs/om_05.jpg',
    'assets/imgs/om_07.jpg',
    'assets/imgs/om_04.jpg',
    'assets/imgs/om_08.jpg',
    'assets/imgs/om_09.png',
    'assets/imgs/om_03.jpg',
    'assets/imgs/om_10.jpg',
    'assets/imgs/om_11.jpg',
    'assets/imgs/om_12.jpg',
    'assets/imgs/om_02.jpg',
    'assets/imgs/om_13.jpg',
    'assets/imgs/om_14.jpg',
    'assets/imgs/om_15.jpg',
    'assets/imgs/om_01.jpg',
    'assets/imgs/om_16.jpg',
    'assets/imgs/om_117.jpg',
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
                itemCount: (words.length / 3).toInt(),
                itemBuilder: (context, index) {
                  final word = words[index * 3];
                  final word2 = words[(index * 3 + 1)];
                  final word3 = words[(index * 3 + 2)];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                bgImg[index % bgImg.length],
                              ), // Or NetworkImage('your_image_url')
                              fit: BoxFit.cover, // This makes the image cover the container
                            ),
                          ),
                          padding: EdgeInsets.only(top: 40),
                          child: Dec.head(
                            "${word.chapter}:${word.serial}",
                            word.name.toString(),
                            dark,
                          ),
                        ),
                        // Dec.name(word.name.toString(), dark),
                        TextView(
                          t1st: "${word.sanskrit}\n\n${word2.sanskrit}\n\n${word3.sanskrit}",
                          t2nd: "${word.bengali}\n\n${word2.bengali}\n\n${word3.bengali}",
                          t3rd: "${word.english}\n\n${word2.english}\n\n${word3.english}",
                          lang: bang,
                          dark: dark,
                          siz: 0,
                          bgs: 1,
                        ),
                        Decor.line(dark),
                        TextView(
                          t1st:
                              "${word.wordMeaning}\n\n${word2.wordMeaning}\n\n${word3.wordMeaning}",
                          t2nd: "${word.bng_mean}\n\n${word2.bng_mean}\n\n${word3.bng_mean}",
                          t3rd: "${word.eng_mean}\n\n${word2.eng_mean}\n\n${word3.eng_mean}",
                          lang: bang,
                          dark: dark,
                          siz: 0,
                          bgs: 0,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingBtn(),
      bottomNavigationBar: BBar.buildSlider(
        maxLim: numShl,
        currentSliderValue: _currentSliderValue,
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
            getPage(value.toInt());
          });
        },
      ),
    );
  }
}
