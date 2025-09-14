import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/data/get_tracks.dart';
import 'package:slokas/data/models/tracks.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';
import 'package:slokas/data/get_shlokas.dart';
import 'package:slokas/data/models/shlokas.dart';

class LongShloka extends StatefulWidget {
  const LongShloka({super.key});

  @override
  State<LongShloka> createState() => _LongShlokaState();
}

class _LongShlokaState extends State<LongShloka> {
  Future<List<ShlokaModel>>? slk;
  final GetShloka _repo = GetShloka();
  Map<int, int> lang = {};
  Map<int, int> mean = {};
  bool dark = true;
  Random rand = Random();
  int r_num = 0;
  late PageController pageCon;

  void gPage() async {
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
  }

  void setPage(int page) async {
    await GetTracks().uKindTrack(
      Track(kinds: 'page', main: '/long', subs: page),
    );
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
                                bgImg[r_num],
                              ), // Or NetworkImage('your_image_url')
                              fit: BoxFit
                                  .cover, // This makes the image cover the container
                            ),
                          ),
                          child: Dec.head(index.toString(), '', dark),
                        ),
                        Dec.name(word.name.toString(), dark),
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
