import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slokas/data/get_shlokas.dart';
import 'package:slokas/data/shloka_database.dart';
import 'package:slokas/pages/gitashloka.dart';
import 'package:slokas/pages/homepage.dart';
import 'package:slokas/pages/longshloka.dart';
import 'package:slokas/pages/phonetics.dart';
import 'package:slokas/pages/shortshloka.dart';
import 'package:slokas/pages/words.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allows normal portrait orientation
    DeviceOrientation.portraitDown, // Allows upside-down portrait orientation
  ]);
  final db = ShlokaDatabase.instance;
  await GetShloka().insertShort();
  await GetShloka().insertLong();
  await GetShloka().insertGita();
  await GetShloka().words();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Homepage(),
        '/short': (context) => SingleShloka(),
        '/long': (context) => LongShloka(),
        '/gita': (context) => GitaShloka(),
        '/word': (context) => WordMeaning(),
        '/font': (context) => SanskritPhoneticsTable(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      initialRoute: "/font",
    );
  }
}
