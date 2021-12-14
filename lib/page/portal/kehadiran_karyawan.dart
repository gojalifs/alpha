import 'dart:convert';

import 'package:alpha/db_helper/album.dart';
import 'package:alpha/page/portal/absen.dart';
import 'package:alpha/page/portal/wfo.dart';
import 'package:alpha/utils/url.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AbsensiPortal extends StatefulWidget {
  // const AbsensiPortal({Key? key}) : super(key: key);

  @override
  _AbsensiPortalState createState() => _AbsensiPortalState();
}

class _AbsensiPortalState extends State<AbsensiPortal> {
  final _formWFOKey = GlobalKey<FormState>();
  WFO _wfo = WFO();
  Absence _absence = Absence();

  int showFormIndex = 0;

  List<CheckBoxCondition> _checkList = CheckBoxCondition.getCOnditions();
  List _conditions = [];

  Color _fgColor = Colors.white;
  Color _bgColor = Colors.green;

  bool _changeColor = true;

  /// radio button
  String _kondisi = 'Sehat';
  bool _bergejala = false;

  int _rvaluegroup = -1;

  final List<RadioGroup> _cond = [
    RadioGroup(index: 1, text: "Sehat"),
    RadioGroup(index: 2, text: "Bergejala"),
  ];

  bool _visible = false;

  loadProgress() {
    setState(() {
      _visible = !_visible;
    });
  }

  void _changeIndex(int index) {
    setState(() {
      showFormIndex = index;
    });
  }

  String isUpdated = 'a';

  @override
  void initState() {
    super.initState();
    _checkPortalStatus();
    print("already ${isUpdated}");
  }

  Future _future = _checkPortalStatus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          'Konfirmasi Kehadiran Karyawan',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data == 'already exist') {
                // return Card(
                //   child: Text(
                //       "Anda sudah melakukan update portal hari ini, silahkan update lagi besok :)"),
                // );
                // return showDialog(
                //   context: context,
                //   builder: (BuildContext context) => AlertDialog(content: Card(child: Text('sdsds'),),),
                // );
                return Center(
                  child: AlertDialog(
                    insetPadding: EdgeInsets.all(80),
                    content: Wrap(
                      children: [
                        Text(
                          'Anda sudah update portal hari ini. Silahkan anda lakukan update portal lagi besok :)',
                          style: TextStyle(fontSize: 20),
                        ),
                        Image.asset('images/done_animation.gif'),
                      ],
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    _bodyPortal(context),
                  ],
                ));
              }
            } else
              return Text("ERROR");
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Column _bodyPortal(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        showFormIndex == 0
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Card(
                  elevation: 7,
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              showFormIndex == 1
                                  ? _wfo
                                  : showFormIndex == 2
                                      ? _absence
                                      : showFormIndex == 3
                                          ? _showWFH()
                                          : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  Widget buildCondition() {
    return Column(
      children: [
        ListView.builder(
          primary: false,
          itemCount: _cond.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var _condition = _cond[index];
            return RadioListTile(
              title: Text(_condition.text),
              value: _condition.index,
              groupValue: _rvaluegroup,
              onChanged: (int? value) {
                setState(() {
                  _rvaluegroup = value!;
                  _kondisi = _condition.text;
                  _condition.index == 1
                      ? _bergejala = false
                      : _bergejala = true;
                  // _rvaluegroup == 1 ? _conditions.clear() : null;
                });
              },
            );
          },
        ),
        _bergejala ? buildBergejala() : SizedBox(),
      ],
    );
  }

  _showWFH() {
    return Column(
      children: [
        Text("FORM WFH"),
      ],
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          children: [
            Card(
              // color: Theme.of(context).accentColor,
              child: Container(
                width: MediaQuery.of(context).size.width - 25,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'YMMI',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Divider(
                      height: 25,
                      color: Colors.white,
                    ),
                    Column(
                      children: [
                        Text(
                          "Sesuai dengan PKB Pasal 42 Ayat 51, Maka Seluruh Karyawan Wajib Untuk Mengisi Sesuai Informasi Dengan Jujur dan Sebenar-benarnya",
                          textAlign: TextAlign.justify,
                        ),
                        Divider(
                          height: 5,
                          color: Colors.white,
                        ),
                        Text(
                          "Apakah Anda Akan Datang Bekerja Hari ini?",
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                _changeIndex(1);
                              },
                              child: Text(
                                "YA",
                                style: TextStyle(color: _fgColor),
                              ),
                              color: _bgColor,
                            ),
                            MaterialButton(
                              onPressed: () {
                                _changeIndex(2);
                              },
                              child: Text(
                                "TIDAK",
                                style: TextStyle(color: _fgColor),
                              ),
                              color: _bgColor,
                            ),
                            MaterialButton(
                              onPressed: () {
                                _changeIndex(3);
                              },
                              child: Text(
                                "SAH",
                                style: TextStyle(color: _fgColor),
                              ),
                              color: _bgColor,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RadioGroup {
  int index;
  String text;

  RadioGroup({required this.index, required this.text});
}

class CheckBoxCondition {
  String title;
  bool isCheck;

  CheckBoxCondition({required this.title, required this.isCheck});

  static List<CheckBoxCondition> getCOnditions() {
    return <CheckBoxCondition>[
      CheckBoxCondition(title: "Demam > 37.3 \u2103", isCheck: false),
      CheckBoxCondition(title: "Batuk", isCheck: false),
      CheckBoxCondition(title: "Sesak Nafas", isCheck: false),
      CheckBoxCondition(title: "Sakit Tenggorokan", isCheck: false),
      CheckBoxCondition(title: "Pilek", isCheck: false),
      CheckBoxCondition(title: "Kehilangan Rasa dan Bau", isCheck: false),
      CheckBoxCondition(title: "Gejala Lain", isCheck: false),
    ];
  }
}

Future _checkPortalStatus() async {
  var _id = id;
  var resp = await http.get(Uri.parse('${url}check_portal.php?id=$_id'));

  String result = jsonDecode(resp.body);
  print(result);
  return result;
}
