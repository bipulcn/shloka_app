import 'package:flutter/material.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/data/get_tracks.dart';
import 'package:slokas/data/models/tracks.dart';
import 'package:slokas/parts/floating_btn.dart';
import 'package:slokas/const/colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool dark = true;
  @override
  void initState() {
    super.initState();
    gPage();
  }

  void gPage() async {
    List<Track> ck = await GetTracks().rdByKind('theme');
    if (ck.isNotEmpty) {
      GetTracks().createTrack(Track(kinds: 'theme', main: 'dark', subs: 0));
      dark = true;
    }
    List<Track> tk = await GetTracks().rdByKind('page');
    if (tk.isNotEmpty) {
      Navigator.pushReplacementNamed(context, tk.first.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark ? Clr.dPri : Clr.lPri,
      // appBar: AppBar(title: Text("This is app bar")),
      body: SafeArea(
        child: Column(
          children: [
            Dec.impTx("working", dark),
            TextButton(
              onPressed: () {
                Track obj = Track(
                  id: 1,
                  kinds: 'page',
                  main: '/short',
                  subs: 2,
                );
                GetTracks().uKindTrack(obj);
              },
              child: Text('Save Value'),
            ),
            TextButton(
              onPressed: () async {
                var dt = await GetTracks().rdByKind('page');
                debugPrint(dt!.first.main);
              },
              child: Text("Get Text"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingBtn(),
    );
  }
}
