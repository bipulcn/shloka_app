import 'dart:async';

import 'package:float_column/float_column.dart';
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
  Timer? _debounce;
  List<Word> _filteredWords = [];

  void gPage() async {
    List<Track> th = await GetTracks().rdByKind('theme');
    if (th.isNotEmpty) {
      dark = th.first.main == "dark" ? true : false;
    }
    setState(() {});
  }

  @override
  void initState() {
    gPage();
    super.initState();
    slk = _repo.readAllWords();
  }

  void searchText() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    search.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // void _onSearchChanged() {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 300), () {
  //     _filterWords(search.text);
  //   });
  // }

  List<Word> _filterWords(List<Word> words, String query) {
    if (query.isEmpty) return words;

    final lowerCaseQuery = query.toLowerCase();

    return _filteredWords = words
        .where(
          (word) =>
              word.pronounce.toLowerCase().contains(lowerCaseQuery) ||
              word.sanskrit.toLowerCase().contains(lowerCaseQuery) ||
              word.english.toLowerCase().contains(lowerCaseQuery) ||
              word.bengali.toLowerCase().contains(lowerCaseQuery),
        )
        .toList();
  }

  void _clearSearch() {
    search.clear();
    setState(() {
      // _filteredWords = widget.words;
    });
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
                  fillColor: dark ? Clr.dPri : Clr.lPri,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  labelText: "Search",
                ),
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {}); // Trigger rebuild on text change
                },
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
                    final filteredWords = _filterWords(words, search.text);
                    if (filteredWords.isEmpty) {
                      return Center(
                        child: Text(
                          search.text.isEmpty
                              ? 'No words available'
                              : 'No results found for "${search.text}"',
                        ),
                      );
                    }
                    return Scrollbar(
                      // Optional: Make the scrollbar thumb always visible
                      thumbVisibility: true,
                      // Optional: Make the scrollbar track always visible
                      trackVisibility: true,
                      // Optional: Adjust the thickness of the scrollbar
                      thickness: 10.0,
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: ListView.builder(
                        itemCount: filteredWords.length,
                        itemBuilder: (context, index) {
                          final word = filteredWords[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: FloatColumn(
                              children: [
                                Floatable(
                                  float: FCFloat.start,
                                  padding: EdgeInsets.only(right: 8),
                                  child: SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Dec.word(
                                      "${word.sanskrit} (${word.pronounce})",
                                      dark,
                                    ),
                                  ),
                                ),

                                Dec.wordMean(
                                  "${word.english}\n${word.bengali}",
                                  dark,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
