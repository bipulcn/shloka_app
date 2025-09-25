import 'package:flutter/material.dart';
import 'package:slokas/component/buttons.dart';
import 'package:slokas/data/alphabet.dart';

class Bornas extends StatelessWidget {
  final bool dark;
  const Bornas({super.key, required this.dark});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
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

class Akars extends StatelessWidget {
  final bool dark;
  const Akars({super.key, required this.dark});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  color: WidgetStateProperty<Color?>.fromMap(<WidgetStatesConstraint, Color?>{
                    WidgetState.any: dark ? Colors.black : Colors.white,
                  }),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class AllAkars extends StatelessWidget {
  final bool dark;
  const AllAkars({super.key, required this.dark});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  color: WidgetStateProperty<Color?>.fromMap(<WidgetStatesConstraint, Color?>{
                    WidgetState.any: dark ? Colors.black : Colors.white,
                  }),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class Combined extends StatefulWidget {
  final bool dark;
  const Combined({super.key, required this.dark});

  @override
  State<Combined> createState() => _CombinedState();
}

class _CombinedState extends State<Combined> {
  int _selRow = 1;
  int _selCol = 1;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 1; i < joints[0].length; i++)
                    Btn.tBtn(joints[0][i].toString(), () {
                      _selCol = i;
                      setState(() {});
                    }),
                ],
              ),
            ),

            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 1; i < joints[_selCol].length; i++)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                      child: Text(
                        "${joints[_selCol][0]} + ${joints[0][i]} = ${joints[_selCol][i]}",
                        style: alpSt(widget.dark),
                      ),
                    ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 1; i < joints.length; i++)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                      child: Text(
                        "${joints[_selRow][0]} + ${joints[0][i]} = ${joints[_selRow][i]}",
                        style: alpSt(widget.dark),
                      ),
                    ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 1; i < joints.length; i++)
                    Btn.tBtn(joints[i][0], () {
                      _selRow = i;
                      setState(() {});
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle alpSt(bool dark) => TextStyle(color: dark ? Colors.white : Colors.black, fontSize: 22);
}
