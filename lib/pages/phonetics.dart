import 'package:flutter/material.dart';
import 'package:slokas/const/colors.dart';
import 'package:slokas/data/alphabet.dart';
import 'package:slokas/data/get_tracks.dart';
import 'package:slokas/data/models/tracks.dart';
import 'package:slokas/parts/floating_btn.dart';

class SansKritPhonetics extends StatefulWidget {
  const SansKritPhonetics({super.key});

  @override
  State<SansKritPhonetics> createState() => _SansKritPhoneticsState();
}

class _SansKritPhoneticsState extends State<SansKritPhonetics> {
  bool dark = true;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark ? Clr.dPri : Clr.lPri,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                // Horizontal scrolling within the vertical scroll
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: DataTable(
                    columnSpacing: 4.0,
                    horizontalMargin: 1.0,
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
                        color: WidgetStateProperty<Color?>.fromMap(<WidgetStatesConstraint, Color?>{
                          WidgetState.any: dark ? Colors.black : Colors.white,
                        }),
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
                                  color: dark ? Colors.white : Colors.black,
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
              SingleChildScrollView(
                // Horizontal scrolling within the vertical scroll
                scrollDirection: Axis.horizontal,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  child: DataTable(
                    columnSpacing: 8.0,
                    horizontalMargin: 4.0,
                    headingRowHeight: 0,
                    dataRowMinHeight: 40,
                    dataRowMaxHeight: 50,
                    columns: [for (int i = 0; i < 5; i++) DataColumn(label: Text(""))],
                    rows: cells
                        .map(
                          (rw) => DataRow(
                            cells: [
                              for (int i = 0; i < 5; i++)
                                DataCell(
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      rw[i],
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: dark ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                            color: WidgetStateProperty<Color?>.fromMap(
                              <WidgetStatesConstraint, Color?>{
                                WidgetState.any: dark ? Colors.black : Colors.white,
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              SingleChildScrollView(
                // Horizontal scrolling within the vertical scroll
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: DataTable(
                    columns: [for (int i = 0; i < 13; i++) DataColumn(label: Text(""))],
                    rows: combine
                        .map(
                          (rw) => DataRow(
                            cells: [
                              for (int i = 0; i < 13; i++)
                                DataCell(
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      rw[i],
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: dark ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                            color: WidgetStateProperty<Color?>.fromMap(
                              <WidgetStatesConstraint, Color?>{
                                WidgetState.any: dark ? Colors.black : Colors.white,
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingBtn(),
    );
  }

  double _getFontSize(String text) {
    if (text.length <= 2) return 14;
    if (text.length <= 4) return 12;
    return 10;
  }

  FontWeight _getFontWeight(int rowIndex, String text) {
    if (rowIndex == 0) return FontWeight.bold;
    if (text.contains('☑') || text.contains('☆')) return FontWeight.bold;
    return FontWeight.normal;
  }

  Color _getTextColor(String text) {
    if (text.contains('☑')) return Colors.green;
    if (text.contains('☆')) return Colors.blue;
    if (text.isEmpty) return Colors.grey[400]!;
    return Colors.black;
  }

  DataCell _buildPhoneticCell(List<String> data) {
    if (data[0].isEmpty) return DataCell(Container());

    return DataCell(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 11),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data[0],
              style: TextStyle(
                color: dark ? Colors.white : Colors.black,
                fontFamily: 'Karma',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              data[1],
              style: TextStyle(color: dark ? Colors.white : Colors.black, fontSize: 12),
            ),
            Text(
              data[2],
              style: TextStyle(fontSize: 10, color: dark ? Colors.white70 : Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
