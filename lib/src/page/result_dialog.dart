import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ResultDialog extends StatefulWidget {
  const ResultDialog({
    @required this.selectedDate,
    @required this.jumlahBox,
    @required this.priode,
  });

  final List<DateTime> selectedDate;
  final int jumlahBox;
  final int priode;

  @override
  _ResultDialogState createState() => new _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  List<Widget> dateBuilder(BuildContext context) {
    return widget.selectedDate.map((date) {
      return new Container(
        color: const Color(0xfffef4e7),
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        child: new Text(
          date.toString(),
          style: new TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Result dari Langganan'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("Jumlah box yang di pesan ${widget.jumlahBox} Box"),
            new Text("Priode hari yang di pilih adalah ${widget.priode} Hari"),
            new Text("List tanggal yang di pilih *scroll: "),
            new Expanded(
              child: new ListView(
                  scrollDirection: Axis.vertical,
                  children: dateBuilder(context)),
            )
          ],
        ),
      ),
    );
  }
}
