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

class LongShloka extends StatefulWidget {
  const LongShloka({super.key});

  @override
  State<LongShloka> createState() => _LongShlokaState();
}

class _LongShlokaState extends State<LongShloka> {
  double _currentSliderValue = 1;
  Future<List<ShlokaModel>>? slk;
  final GetShloka _repo = GetShloka();
  Map<int, int> lang = {};
  Map<int, int> mean = {};
  bool dark = true;
  Random rand = Random();
  int r_num = 0;
  late PageController pageCon = PageController(initialPage: 0);
  int bang = 0;
  int lngW = 0;
  int numShl = 1;
  bool _isLoading = true;

  void gPage() async {
    List<Track> ln = await GetTracks().rdByKind('bengali');
    if (ln.isNotEmpty) {
      bang = ln.first.main == 'yes' ? 1 : 0;
    }
    List<Track> th = await GetTracks().rdByKind('theme');
    if (th.isNotEmpty) {
      dark = th.first.main == "dark" ? true : false;
    }
    List<Track> tk = await GetTracks().rdByKind('long');
    if (tk.isNotEmpty) {
      pageCon = PageController(initialPage: tk.first.subs);
    } else {
      pageCon = PageController(initialPage: 0);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void setPage(int page) async {
    await GetTracks().uKindTrack(Track(kinds: 'page', main: '/long', subs: page));
    await GetTracks().uKindTrack(Track(kinds: 'long', main: '', subs: page));
  }

  @override
  void initState() {
    gPage();
    super.initState();
    slk = _repo.getShlokaByCat('long');
    int ind = 0;
    slk?.then((SList) {
      for (var itm in SList) {
        lang[ind] = 0;
        mean[ind] = 0;
        ind++;
      }
      numShl = ind;
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

  Future<void> getPage(int num) async {
    setPage(num);
    pageCon.animateToPage(num, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: dark ? Clr.dPri : Clr.lPri,
        // appBar: AppBar(title: Text("This is app bar")),
        body: SafeArea(
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading content from database...'),
              ],
            ),
          ),
        ),
      );
    }
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                bgImg[index % bgImg.length],
                              ), // Or NetworkImage('your_image_url')
                              fit: BoxFit.cover, // This makes the image cover the container
                            ),
                          ),
                          padding: EdgeInsets.only(top: 140),
                          child: Dec.head(
                            "${word.chapter}:${word.serial}",
                            word.name.toString(),
                            dark,
                          ),
                        ),
                        TextView(
                          t1st: word.sanskrit,
                          t2nd: word.bengali,
                          t3rd: "",
                          lang: bang,
                          dark: dark,
                          siz: 0,
                          bgs: 1,
                        ),
                        Decor.line(dark),
                        TextView(
                          t1st: word.eng_mean,
                          t2nd: word.bng_mean,
                          t3rd: word.wordMeaning,
                          lang: lngW,
                          dark: dark,
                          siz: 0,
                          bgs: 0,
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       mean[index] = mean[index] == 0 ? 1 : 0;
                        //     });
                        //   },
                        //   child: Dec.bdyTx(
                        //     mean[index] == 1 ? word.bng_mean : word.eng_mean,
                        //     dark,
                        //   ),
                        // ),
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
