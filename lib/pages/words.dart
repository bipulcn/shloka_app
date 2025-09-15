import 'package:flutter/material.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/data/get_tracks.dart';
import 'package:slokas/data/get_words.dart';
import 'package:slokas/data/models/tracks.dart';
import 'package:slokas/data/models/words.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';

class WordMeaning extends StatefulWidget {
  const WordMeaning({super.key});

  @override
  State<WordMeaning> createState() => _WordMeaningState();
}

class _WordMeaningState extends State<WordMeaning> {
  TextEditingController search = TextEditingController();
  Future<List<Word>>? slk;
  final GetWords _repo = GetWords();
  bool dark = true;
  Map<int, int> lang = {};
  Map<int, int> mean = {};

  void gPage() async {
    List<Track> th = await GetTracks().rdByKind('theme');
    if (th.isNotEmpty) {
      dark = th.first.main == "dark" ? true : false;
    }
  }

  @override
  void initState() {
    gPage();
    super.initState();
    slk = _repo.readAllWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark ? Clr.dPri : Clr.lPri,
      // appBar: AppBar(title: Text("This is app bar")),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // color: Colors.amber,
              child: TextFormField(
                controller: search,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  labelText: "Search",
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Word>>(
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
                    return ListView.builder(
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        final word = words[index];
                        if (word.pronounce.contains(search.text)) {
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.white38,
                                width: 0,
                              ), // Customize color and width
                              borderRadius: BorderRadius.circular(
                                2,
                              ), // Add border radius if desired
                            ),
                            title: Dec.word(
                              "${word.sanskrit} (${word.pronounce})",
                              dark,
                            ),
                            subtitle: Dec.wordMean(
                              "${word.english}\n${word.bengali}",
                              dark,
                            ),
                          );
                        } else {
                          return null;
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingBtn(),
    );
  }
}
