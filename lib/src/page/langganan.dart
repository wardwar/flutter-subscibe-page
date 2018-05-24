import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kulina/resources/decoration.dart';
import 'package:kulina/resources/hover_button.dart';
import 'package:kulina/resources/toggle_button.dart';
import 'package:intl/intl.dart';
import 'package:kulina/src/calendar/calendar.dart';
import 'package:date_utils/date_utils.dart';
import 'package:intl/date_symbol_data_local.dart';


class LanggananPage extends StatefulWidget {
  LanggananPage({Key key, this.title}) : super(key: key);
  final String title;
  final NumberFormat f = new NumberFormat();
  final enDatesFuture = initializeDateFormatting('in_ID', null);
  final DateFormat d = new DateFormat("EEEE, d MMM y","in_ID");

  @override
  _Langganan createState() => new _Langganan();
}

class _Langganan extends State<LanggananPage> {
  int _box = 1;
  int _hari = 0;
  int _total = 0;
  int _perbox = 0;
  bool _20Hari = false;
  bool _10Hari = false;
  bool _5Hari = true;
  bool _pilihSendiri = false;
  List<DateTime> _dateCallback;
  int _harisendiri = 2;
  int _hargasendiri =25000;

  void _handleHari(int hari) {
    setState(() {
      _resetButton();
      if (hari == 20) {
        _20Hari = true;
        selectedData.addAll(dayRangeIgnoreHoliday(20));
      }
      else if (hari == 10) {
        _10Hari = true;
        selectedData.addAll(dayRangeIgnoreHoliday(10));
      }
      else if (hari == 5) {
        _5Hari = true;
        selectedData.addAll(dayRangeIgnoreHoliday(5));
      }
      else
        _pilihSendiri = true;
    });
  }

  void _resetButton() {
    setState(() {
      _20Hari = false;
      _10Hari = false;
      _5Hari = false;
      _pilihSendiri = false;
    });
  }

  List<DateTime> selectedData;

  @override
  void initState() {
    selectedData = List<DateTime>();
    _dateCallback = List<DateTime>();
    var range = dayRangeIgnoreHoliday(5);
    selectedData.addAll(range);
    _dateCallback.addAll(range);
    _handleLangganan(5, 25000);
    _hari = 5;
  }

  List<DateTime> dayRangeIgnoreHoliday(int days) {
    selectedData.clear();
    var now = new DateTime.now().add(new Duration(days: 1));
    var first = new DateTime(now.year, now.month, now.day);
    var until = first.add(new Duration(days: days));
    var range = Utils
        .daysInRange(first, until)
        .toList()
        .where((DateTime date) => date.weekday != 6 && date.weekday != 7)
        .toList();

    if (range.length < days) {
      range.add(until);
    }
    List<DateTime> newRange = _addDays(range, until, days);

    return newRange;
  }

  List<DateTime> _addDays(List<DateTime> range, DateTime until, int days) {
    var c = 1;
    var lenght = range.length;
    while (lenght < days) {
      var newDate = until.add(new Duration(days: c));
      if (range.contains(newDate))
        c++;
      else {
        range.add(newDate);
        var newRange = range.where((DateTime date) =>
        date.weekday != 6 && date.weekday != 7).toList();
        lenght = newRange.length;
      }
    }
    return range.where((DateTime date) =>
    date.weekday != 6 && date.weekday != 7).toList();
  }

  void _boxSub() {
    if (_box > 1)
      setState(() {
        _box -= 1;
      });
    _handleLangganan(_hari, _perbox);
  }

  void _boxAdd() {
    setState(() {
      _box += 1;
    });
    _handleLangganan(_hari, _perbox);
  }


  void _handleLangganan(int hari, int harga) {
    setState(() {
      _hari = hari;
      _perbox = harga;
      _total = _box * (_hari * harga);
      _handleHari(hari);
    });
    
  }
  

  String fnumb(int number) {
    return widget.f.format(number);
  }


  Future<Null> _pilihSendiriDialog() async {
    switch (await showDialog<LanggananPage>(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new Text('Pilih Priode Langganan',style: medium),
            children: <Widget>[
              new Padding(
                  padding: new EdgeInsets.all(16.0),
                child: new Column(
                  children: <Widget>[
                    new TextField(
                      onChanged: (text){
                        setState(() {

                            _harisendiri = int.parse(text);
                        });
                      },
                      style: medium,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              new RaisedButton(color:yellow,
                onPressed: (){
                  if(_harisendiri < 2)
                    showDialog(context: context,builder: (BuildContext context){
                      return new AlertDialog(
                        content: new Text("Pilih Minimal 2 hari",style: medium),
                      );
                    });
                  else if(_harisendiri > 40)
                    showDialog(context: context,builder: (BuildContext context){
                      return new AlertDialog(
                        content: new Text("maksimal 40 hari",style: medium),
                      );
                    });
                  else {
                    var harga;
                    if (_harisendiri > 0 && _harisendiri < 10)
                      harga = 25000;
                    else if (_harisendiri > 10 && _harisendiri < 20)
                      harga = 24250;
                    else
                      harga = 22500;
                    _handleLangganan(_harisendiri, harga);
                    Navigator.of(context).pop();
                  }
                },
                child: new Text("OK",style: mediumWhite,),)
            ],
          );
        }
    )) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: new BackButton(color: Colors.black54),
          title: new Column(
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(top: 16.0),
                child: new Text(
                  'Mulai Langganan',
                  style: new TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
          bottom: new PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: new Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: new Container(
                height: 72.0,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                            width: 80.0,
                            child: new Text("Mulai",
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                    color: const Color(0xfffd9714)))),
                        new Container(
                            width: 80.0,
                            child: new Text(
                              "Pengiriman",
                              textAlign: TextAlign.center,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body2,
                            )),
                        new Container(
                            width: 80.0,
                            child: new Text(
                              "Pembayaran",
                              textAlign: TextAlign.center,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body2,
                            )),
                      ],
                    ),
                    new Padding(
                      padding: new EdgeInsets.symmetric(horizontal: 74.0),
                      child: new Row(
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: stepActive,
                              ),
                            ],
                          ),
                          rowDivider,
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: step,
                              ),
                            ],
                          ),
                          rowDivider,
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: step,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: new Container(
          color: const Color(0xfff2f3f4),
          child: new SingleChildScrollView(
              padding: new EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 64.0),
              scrollDirection: Axis.vertical,
              child: new Column(
                children: <Widget>[
                  new Container(
                      padding: new EdgeInsets.symmetric(
                          vertical: 32.0, horizontal: 16.0),
                      margin: new EdgeInsets.only(bottom: 32.0),
                      decoration: mainCard,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.only(bottom: 16.0),
                            child: new Text('Jumlah box per hari',
                                textAlign: TextAlign.end, style: big),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Expanded(
                                flex: 3,
                                child: new HoverButton(
                                    fill: Colors.white,
                                    border: yellow,
                                    height: 50.0,
                                    margin: new EdgeInsets.only(right: 8.0),
                                    child: new Text("$_box Box", style: big)),
                              ),
                              new Expanded(
                                child: new HoverButton(
                                  onPressed: _boxSub,
                                  higlight: red,
                                  fill: yellow,
                                  border: red,
                                  margin: new EdgeInsets.only(right: 2.0),
                                  leftRound: true,
                                  height: 50.0,
                                  child: new Icon(Icons.remove,
                                      color: Colors.white, size: 30.0),
                                ),
                              ),
                              new Expanded(
                                child: new HoverButton(
                                  onPressed: _boxAdd,
                                  higlight: red,
                                  fill: yellow,
                                  border: red,
                                  rightRound: true,
                                  height: 50.0,
                                  child: new Icon(Icons.add,
                                      color: Colors.white, size: 30.0),
                                ),
                              ),
                            ],
                          ),
                          new Padding(
                            padding:
                            new EdgeInsets.only(bottom: 16.0, top: 32.0),
                            child: new Text('Lama Langganan',
                                textAlign: TextAlign.end, style: big),
                          ),
                          new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new ToggleButton(
                                  toggel: () {
                                    _handleLangganan(20, 22500);
                                  },
                                  margin: new EdgeInsets.only(
                                      right: 4.0, bottom: 8.0),
                                  fill: _20Hari ? yellow : Colors.white,
                                  border: yellow,
                                  height: 70.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text('20 Hari',
                                          style: _20Hari ? bigWhite : big),
                                      new Text('Rp 22,500/hari',
                                          style: _20Hari ? mediumWhite : medium)
                                    ],
                                  ),
                                ),
                              ),
                              new Expanded(
                                child: new ToggleButton(
                                  margin: new EdgeInsets.only(
                                      bottom: 8.0, left: 4.0),
                                  fill: _10Hari ? yellow : Colors.white,
                                  toggel: () {
                                    _handleLangganan(10, 24250);
                                  },
                                  border: yellow,
                                  height: 70.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text('10 Hari',
                                          style: _10Hari ? bigWhite : big),
                                      new Text('Rp 24,250/hari',
                                          style: _10Hari ? mediumWhite : medium)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new ToggleButton(
                                  toggel: () {
                                    _handleLangganan(5, 25000);
                                  },
                                  margin: new EdgeInsets.only(right: 4.0),
                                  fill: _5Hari ? yellow : Colors.white,
                                  border: yellow,
                                  height: 70.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text('5 Hari',
                                          style: _5Hari ? bigWhite : big),
                                      new Text('Rp 25,000/hari',
                                          style: _5Hari ? mediumWhite : medium)
                                    ],
                                  ),
                                ),
                              ),
                              new Expanded(
                                child: new ToggleButton(
                                  margin: new EdgeInsets.only(left: 4.0),
                                  fill: _pilihSendiri ? yellow : Colors.white,
                                  toggel: (){
                                    _pilihSendiriDialog();
                                  },
                                  height: 70.0,
                                  border: yellow,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(_pilihSendiri
                                          ? "$_hari Hari"
                                          : 'Pilih Sendiri',
                                          style: _pilihSendiri
                                              ? bigWhite
                                              : big),
                                      new Text(_pilihSendiri
                                          ? "Rp ${fnumb(_perbox)}"
                                          : 'Min. 2 hari', style: _pilihSendiri
                                          ? mediumWhite
                                          : medium)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new Container(
                                  margin:
                                  new EdgeInsets.symmetric(vertical: 32.0),
                                  decoration: mainCard,
                                  child: new ConstrainedBox(
                                    constraints: new BoxConstraints(),
                                    child: new Calendar(
                                      onDateSelected: (List<DateTime> dateCallback) {
                                        setState(() {
                                          _dateCallback.clear();
                                          _dateCallback.addAll(dateCallback);
                                          _dateCallback.sort();
                                          _hari = _dateCallback.length;
                                          var harga;
                                          if(_hari >0 && _hari < 10)
                                            harga = 25000;
                                          else if(_hari > 10 && _hari < 20)
                                            harga = 24250;
                                          else
                                            harga = 22500;
                                          _handleLangganan(_hari, harga);
                                        });
                                      },
                                      selectedData: selectedData,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new Container(
                                    padding: new EdgeInsets.all(16.0),
                                    decoration: SecondaryCard,
                                    child: new Row(
                                      children: <Widget>[
                                        new Flexible(
                                          child: new Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text('Pro Tips',
                                                  style: new TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 14.0,
                                                      color: Colors.black87)),
                                              new Text(
                                                  'Atur jadwal langganan dengan menekan tanggal pada kalendar. Selesaikan transaksi sebelum pukul 19:00 untuk mulai pengiriman besok.',
                                                  textAlign: TextAlign.left,
                                                  style: new TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      )),
                  new Container(
                    margin: new EdgeInsets.only(bottom: 32.0),
                    padding: new EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
                    decoration: mainCard,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Padding(
                                  padding: new EdgeInsets.only(bottom: 16.0),
                                  child: new Text('Rincian Langganan',
                                      textAlign: TextAlign.left, style: big),
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    new Text('Harga per box', style: medium),
                                    new Text(
                                      'Rp ${fnumb(_perbox)}',
                                      style: medium,
                                    ),
                                  ],
                                ),
                                new Divider(),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    new Text('Jumlah Box', style: medium),
                                    new Text('$_box Box', style: medium),
                                  ],
                                ),
                                new Divider(),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    new Text('Lama Langganan', style: medium),
                                    new Text('$_hari Hari', style: medium),
                                  ],
                                ),
                                new Text(
                                  'Mulai ${widget.d.format(_dateCallback[0])}',
                                  style: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                                new Divider(),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    new Text('Total', style: big),
                                    new Text('Rp ${fnumb(_total)}', style: big),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  new GestureDetector(
//                    onTap: _handleBottomSheet,
                    child: new Container(
                      height: 70.0,
                      decoration: mainButton,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Text("Selanjutnya",
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
