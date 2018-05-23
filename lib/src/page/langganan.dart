import 'package:flutter/material.dart';
import 'package:kulina/resources/decoration.dart';
import 'package:kulina/resources/main_button.dart';
import 'package:intl/intl.dart';
import 'package:kulina/src/calendar/calendar.dart';

class LanggananPage extends StatefulWidget {
  LanggananPage({Key key, this.title}) : super(key: key);
  final String title;
  final NumberFormat f = new NumberFormat();


  @override
  _Langganan createState() => new _Langganan();
}

class _Langganan extends State<LanggananPage> {
  int _box = 1;
  int _hari = 0;
  int _total = 0;
  int _perbox = 0;
  Color _subColor = yellow;
  Color _subBorder = yellow;

  Color _addColor = yellow;
  Color _addBorder = yellow;

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

  void _handleLangganan(int hari, int harga){
    setState(() {
      _hari = hari;
      _perbox = harga;
      _total = _box * (_hari * harga);
    });
    print("$_hari dan $_total");
  }

  String fnumb(int number){
    return widget.f.format(number);
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
                              style: Theme.of(context).textTheme.body2,
                            )),
                        new Container(
                            width: 80.0,
                            child: new Text(
                              "Pembayaran",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.body2,
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
                                  child: new MainButton(
                                      color: Colors.white,
                                        border: yellow,
                                        height: 50.0,
                                        margin: new EdgeInsets.only(right: 8.0),
                                        child:
                                        new Text("$_box Box", style: big)),
                                  ),
                              new Expanded(
                                child:
                                new GestureDetector(
                                  onTap: _boxSub,
                                  onTapUp: (TapUpDetails details){
                                    setState(() {
                                      _subColor = yellow;
                                      _subBorder = yellow;
                                    });
                                  },
                                  onTapDown: (TapDownDetails detauls){
                                    setState(() {
                                      _subColor = red;
                                      _subBorder = red;
                                    });
                                  },
                                  child: new MainButton(
                                    color: _subColor,
                                    border: _subBorder,
                                    margin: new EdgeInsets.only(right: 2.0),
                                    leftRound: true,
                                    height: 50.0,
                                    child: new Icon(Icons.remove,
                                        color: Colors.white, size: 30.0),
                                  ),
                                ),
                              ),
                              new Expanded(
                                child: new GestureDetector(
                                  onTap: _boxAdd,
                                  onTapUp: (TapUpDetails details){
                                    setState(() {
                                      _addColor = yellow;
                                      _addBorder = yellow;
                                    });
                                  },
                                  onTapDown: (TapDownDetails detauls){
                                    setState(() {
                                      _addColor = red;
                                      _addBorder = red;
                                    });
                                  },
                                  child: new MainButton(
                                  color: _addColor,
                                  border: _addBorder,
                                  rightRound: true,
                                  height: 50.0,
                                  child: new Icon(Icons.add,
                                      color: Colors.white, size: 30.0),
                                ),
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
                                child:
                                new GestureDetector(
                                  onTap: (){
                                    _handleLangganan(20, 22500);
                                  },
                                  onTapUp: (TapUpDetails details){
                                    setState(() {
                                      _addColor = yellow;
                                      _addBorder = yellow;
                                    });
                                  },
                                  onTapDown: (TapDownDetails detauls){
                                    setState(() {
                                      _addColor = red;
                                      _addBorder = red;
                                    });
                                  },
                                  child:  new MainButton(
                                    margin: new EdgeInsets.only(right: 8.0, bottom: 8.0),
                                    color: Colors.white,
                                    border: yellow,
                                    height: 70.0,
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text('20 Hari', style: big),
                                        new Text('Rp 22,500/hari', style: medium)
                                      ],
                                    ),
                                  ),
                                ),

                              ),
                              new Expanded(
                                child: new GestureDetector(
                                  onTap: (){
                                    _handleLangganan(10, 24250);
                                  },
                                  onTapUp: (TapUpDetails details){
                                    setState(() {
                                      _addColor = yellow;
                                      _addBorder = yellow;
                                    });
                                  },
                                  onTapDown: (TapDownDetails detauls){
                                    setState(() {
                                      _addColor = red;
                                      _addBorder = red;
                                    });
                                  },
                                  child:  new MainButton(
                                    margin: new EdgeInsets.only(bottom: 8.0),
                                    color: Colors.white,
                                    border: yellow,
                                    height: 70.0,
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text('10 Hari', style: big),
                                        new Text('Rp 24,250/hari', style: medium)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new GestureDetector(
                                  onTap: (){
                                    _handleLangganan(5, 25000);
                                  },
                                  onTapUp: (TapUpDetails details){
                                    setState(() {
                                      _addColor = yellow;
                                      _addBorder = yellow;
                                    });
                                  },
                                  onTapDown: (TapDownDetails detauls){
                                    setState(() {
                                      _addColor = red;
                                      _addBorder = red;
                                    });
                                  },
                                  child:  new MainButton(
                                    margin: new EdgeInsets.only(right: 8.0),
                                    color: Colors.white,
                                    border: yellow,
                                    height: 70.0,
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text('5 Hari', style: big),
                                        new Text('Rp 25,000/hari',
                                            style: medium)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              new Expanded(
                                child: new GestureDetector(
                                  child:  new MainButton(
                                    margin: new EdgeInsets.only(right: 8.0),
                                    color: Colors.white,
                                    height: 70.0,
                                    border: yellow,
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text('Pilih Sendiri', style: big),
                                        new Text('Min. 2 hari', style: medium)
                                      ],
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
                                  margin:
                                  new EdgeInsets.symmetric(vertical: 32.0),
                                  decoration: mainCard,
                                  child: new Calendar(),
                                  height: 350.0,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('Jumlah Box', style: medium),
                                new Text('$_box Box', style: medium),
                              ],
                            ),
                            new Divider(),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('Lama Langganan', style: medium),
                                new Text('$_hari Hari', style: medium),
                              ],
                            ),
                            new Text(
                              'Mulai Jumat, 13 April 2018',
                              style: new TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                            new Divider(),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  new Container(
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
                ],
              )),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
