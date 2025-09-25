import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanskrit Phonetics Table',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SanskritPhoneticsTable(),
    );
  }
}

class SanskritPhoneticsTable extends StatelessWidget {
  final List<Map<String, dynamic>> tableData = [
    {
      'place': 'কন্ঠ্য\n(Velar)',
      'sparsa_aghosha_alpaprāṇa': ['क', 'ka', '[k]'],
      'sparsa_aghosha_mahāprāṇa': ['ख', 'kha', '[kʰ]'],
      'sparsa_saghosha_alpaprāṇa': ['ग', 'ga', '[ɡ]'],
      'sparsa_saghosha_mahāprāṇa': ['घ', 'gha', '[ɡʱ]'],
      'anunāsika': ['ङ', 'ṅa', '[ŋ]'],
      'antastha': ['', '', ''],
      'fricative': ['ह', 'ha', '[ɦ]'],
    },
    {
      'place': 'তালব্য\n(Palatal)',
      'sparsa_aghosha_alpaprāṇa': ['च', 'ca', '[tʃ]'],
      'sparsa_aghosha_mahāprāṇa': ['छ', 'cha', '[tʃʰ]'],
      'sparsa_saghosha_alpaprāṇa': ['ज', 'ja', '[dʒ]'],
      'sparsa_saghosha_mahāprāṇa': ['झ', 'jha', '[dʒʱ]'],
      'anunāsika': ['ञ', 'ña', '[ɲ]'],
      'antastha': ['य', 'ya', '[j]'],
      'fricative': ['श', 'śa', '[ʃ]'],
    },
    {
      'place': 'মূর্ধন্য\n(Retroflex)',
      'sparsa_aghosha_alpaprāṇa': ['ट', 'ṭa', '[ʈ]'],
      'sparsa_aghosha_mahāprāṇa': ['ठ', 'ṭha', '[ʈʰ]'],
      'sparsa_saghosha_alpaprāṇa': ['ड', 'ḍa', '[ɖ]'],
      'sparsa_saghosha_mahāprāṇa': ['ढ', 'ḍha', '[ɖʱ]'],
      'anunāsika': ['ण', 'ṇa', '[ɳ]'],
      'antastha': ['र', 'ra', '[r]'],
      'fricative': ['ष', 'ṣa', '[ʂ]'],
    },
    {
      'place': 'দন্ত্য\n(Dental)',
      'sparsa_aghosha_alpaprāṇa': ['त', 'ta', '[t̪]'],
      'sparsa_aghosha_mahāprāṇa': ['थ', 'tha', '[t̪ʰ]'],
      'sparsa_saghosha_alpaprāṇa': ['द', 'da', '[d̪]'],
      'sparsa_saghosha_mahāprāṇa': ['ध', 'dha', '[d̪ʱ]'],
      'anunāsika': ['न', 'na', '[n]'],
      'antastha': ['ल', 'la', '[l]'],
      'fricative': ['स', 'sa', '[s]'],
    },
    {
      'place': 'ওষ্ঠ্য\n(Labial)',
      'sparsa_aghosha_alpaprāṇa': ['प', 'pa', '[p]'],
      'sparsa_aghosha_mahāprāṇa': ['फ', 'pha', '[pʰ]'],
      'sparsa_saghosha_alpaprāṇa': ['ब', 'ba', '[b]'],
      'sparsa_saghosha_mahāprāṇa': ['भ', 'bha', '[bʱ]'],
      'anunāsika': ['म', 'ma', '[m]'],
      'antastha': ['व', 'va', '[ʋ]'],
      'fricative': ['', '', ''],
    },
  ];
  final List<List<String>> joints = [
    [
      "a",
      "ā",
      "i",
      "ī",
      "u",
      "ū",
      "e",
      "ê",
      "ē",
      "ai",
      "o",
      "ô",
      "ō",
      "au",
      "r̥",
      "r̥̄",
      "l̥",
      "l̥̄",
      "ṁ",
      "ḥ",
      "",
      "m̐",
    ],
    [
      "अ",
      "आ",
      "इ",
      "ई",
      "उ",
      "ऊ",
      "ऄ/ऎ",
      "ॲ/ऍ",
      "ए",
      "ऐ",
      "ऒ",
      "ऑ",
      "ओ",
      "औ",
      "ऋ",
      "ॠ",
      "ऌ",
      "ॡ",
      "अं",
      "अः",
      "",
      "अँ",
    ],
    [
      'ka',
      'kā',
      'ki',
      'ku',
      'ku',
      'ke',
      'ke',
      'ke',
      'kai',
      'ko',
      'ko',
      'ko',
      'kau',
      'kr',
      'kr',
      'kl',
      'kĭ',
      'kani',
      'kalp',
      'k',
    ],
    [
      "क",
      "का",
      "कि",
      "की",
      "कु",
      "कू",
      "कॆ",
      "कॅ",
      "के",
      "कै",
      "कॊ",
      "कॉ",
      "को",
      "कौ",
      "कृ",
      "कॄ",
      "कॢ",
      "कॣ",
      "कं",
      "कः",
      "क्",
      "कँ",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sanskrit Phonetics Table'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: DataTable(
            columnSpacing: 8.0,
            horizontalMargin: 4.0,
            headingRowHeight: 0,
            dataRowMinHeight: 60,
            dataRowMaxHeight: 80,
            columns: [
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
            ],
            rows: tableData.map((data) {
              return DataRow(
                color: WidgetStateProperty<Color?>.fromMap(
                  <WidgetStatesConstraint, Color?>{
                    WidgetState.any: Colors.white,
                  },
                ),
                cells: [
                  DataCell(
                    SizedBox(
                      width: 70,
                      child: Text(
                        data['place'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  _buildPhoneticCell(data['sparsa_aghosha_alpaprāṇa']),
                  _buildPhoneticCell(data['sparsa_aghosha_mahāprāṇa']),
                  _buildPhoneticCell(data['sparsa_saghosha_alpaprāṇa']),
                  _buildPhoneticCell(data['sparsa_saghosha_mahāprāṇa']),
                  _buildPhoneticCell(data['anunāsika']),
                  _buildPhoneticCell(data['antastha']),
                  _buildPhoneticCell(data['fricative']),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  DataCell _buildPhoneticCell(List<String> data) {
    if (data[0].isEmpty) return DataCell(Container());

    return DataCell(
      Container(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data[0],
              style: TextStyle(
                fontFamily: 'Karma',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(data[1], style: TextStyle(fontSize: 12)),
            Text(
              data[2],
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
