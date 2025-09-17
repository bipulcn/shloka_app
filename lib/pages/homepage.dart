import 'package:flutter/material.dart';
import 'package:slokas/component/buttons.dart';
import 'package:slokas/component/decorate.dart';
import 'package:slokas/component/decoreate.dart';
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
  bool lang = false;
  @override
  void initState() {
    super.initState();
    gPage();
  }

  void gPage() async {
    List<Track> ck = await GetTracks().rdByKind('theme');
    List<Track> ln = await GetTracks().rdByKind('bengali');
    if (ln.isNotEmpty) {
      lang = ln.first.main == 'yes' ? true : false;
    } else {
      setLanguage();
    }
    if (ck.isNotEmpty) {
      dark = ck.first.main == 'dark' ? true : false;
    } else {
      GetTracks().saveTheme(dark);
    }
    setState(() {});
    // List<Track> tk = await GetTracks().rdByKind('page');
    // if (tk.isNotEmpty) {
    //   Navigator.pushReplacementNamed(context, tk.first.main);
    // }
  }

  void setLanguage() async {
    String typ = lang ? 'no' : 'yes';
    lang = !lang;
    debugPrint(typ);
    GetTracks().saveLanguage(typ);
    setState(() {});
  }

  void setTheme() async {
    String typ = dark ? 'lite' : 'dark';
    dark = !dark;
    GetTracks().saveTheme(dark);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark ? Clr.dPri : Clr.lPri,
      // appBar: AppBar(title: Text("This is app bar")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Bengali",
                style: TextStyle(color: dark ? Colors.black : Colors.white),
              ),
              lang
                  ? Decor().rBox(
                      Dec.bdyTx(
                        "শ্লোকগুলি কেবলমাত্র পদ্য নয়; এগুলি হল চিরন্তন জ্ঞানের সংক্ষিপ্তসার, যা সৃষ্টির খুব কাঠামোর সাথে অনুরণিত হওয়ার জন্য সুনির্দিষ্ট ছন্দ এবং শব্দে নির্মিত। এগুলি চিন্তার সরঞ্জাম, উচ্চতর চেতনার অবস্থা উন্মুক্ত করার চাবিকাঠি এবং ধার্মিক জীবনযাপনের জন্য নির্দেশিকা। ভগবদ গীতা হল সেই divineশ্বরিক সংলাপ যা প্রতিটি মানুষের জীবনের উদ্ভূত হয়। ",
                        dark,
                      ),
                      dark,
                    )
                  : Decor().rBox(
                      Dec.bdyTx(
                        "श्लोक केवल पद्य नहीं हैं; वे शाश्वत ज्ञान के सार संक्षेप हैं, जो सृष्टि के ताने-बाने के साथ अनुनाद करने के लिए सटीक छंद और ध्वनि में निर्मित हैं। भगवद्गीता वह दिव्य संवाद है जो प्रत्येक मनुष्य के जीवन की चौराहे पर उत्पन्न होता है।",
                        dark,
                      ),
                      dark,
                    ),
              Decor.line(dark),
              Decor().rBox(
                Dec.bdyTx(
                  "Hindu shlokas are not mere verses; they are condensed capsules of eternal wisdom, designed with precise meter and sound to resonate with the very fabric of the cosmos. The Bhagavad Gita is the divine dialogue that arises at the crossroads of every human life. ",
                  dark,
                ),
                dark,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Btn.iBtn(dark ? Icons.light_mode : Icons.dark_mode, () {
                    setTheme();
                  }),
                  Btn.iBtn(Icons.translate, () {
                    setLanguage();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingBtn(),
    );
  }
}
