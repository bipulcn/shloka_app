import 'package:flutter/material.dart';
import 'package:slokas/data/get_shlokas.dart';
import 'package:slokas/data/shloka_database.dart';
import 'package:slokas/pages/gitashloka.dart';
import 'package:slokas/pages/homepage.dart';
import 'package:slokas/pages/longshloka.dart';
import 'package:slokas/pages/ramayana.dart';
import 'package:slokas/pages/shortshloka.dart';
import 'package:slokas/pages/words.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = ShlokaDatabase.instance;
  await GetShloka().insertShort();
  await GetShloka().insertLong();
  await GetShloka().insertGita();
  await GetShloka().insertRamayana();
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
        '/ram': (context) => Ramayana(),
        '/word': (context) => WordMeaning(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
    );
  }
}
