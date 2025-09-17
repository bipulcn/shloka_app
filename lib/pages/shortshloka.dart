import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slokas/component/buttons.dart';
import 'package:slokas/parts/bottombar.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/component/decoreate.dart';
import 'package:slokas/data/get_tracks.dart';
import 'package:slokas/data/models/tracks.dart';
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
  double _currentSliderValue = 1;
  Future<List<ShlokaModel>>? slk;
  final GetShloka _repo = GetShloka();
  Map<int, int> lang = {};
  Map<int, int> mean = {};
  bool dark = true;
  Random rand = Random();
  int r_num = 0;
  late PageController pageCon = PageController(initialPage: 0);

  bool bang = false;

  void gPage() async {
    List<Track> ln = await GetTracks().rdByKind('bengali');
    if (ln.isNotEmpty) {
      bang = ln.first.main == 'yes' ? true : false;
    }
    List<Track> th = await GetTracks().rdByKind('theme');
    if (th.isNotEmpty) {
      dark = th.first.main == "dark" ? true : false;
    }
    List<Track> tk = await GetTracks().rdByKind('short');
    if (tk.isNotEmpty) {
      pageCon = PageController(initialPage: tk.first.subs);
    } else {
      pageCon = PageController(initialPage: 0);
    }
    setState(() {});
  }

  void setPage(int page) async {
    await GetTracks().uKindTrack(
      Track(kinds: 'page', main: '/short', subs: page),
    );
    await GetTracks().uKindTrack(Track(kinds: 'short', main: '', subs: page));
  }

  @override
  void initState() {
    gPage();
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
  Widget build(BuildContext context) {
    HSLColor hslColor = HSLColor.fromColor(Clr.cl04);
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
                        Dec.impTx(bang ? word.bengali : word.sanskrit, dark),
                        Decor.line(dark),
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
                        Btn.iBtn(Icons.translate, () {
                          setState(() {
                            bang = !bang;
                            debugPrint(bang.toString());
                          });
                        }),
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
        maxLim: 3,
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
