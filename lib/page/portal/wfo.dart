import 'dart:convert';

import 'package:alpha/db_helper/album.dart';
import 'package:alpha/utils/url.dart';
import 'package:alpha/page/portal/kehadiran_karyawan.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

final _formKey = GlobalKey<FormState>();

class WFO extends StatefulWidget {
  const WFO({Key? key}) : super(key: key);

  @override
  _WFOState createState() => _WFOState();
}

class _WFOState extends State<WFO> {
  int showFormIndex = 0;

  String _statusFit =
      'Dari laporan anda, diketahui bahwa Anda tidak memiliki gejala '
      'yang berhubungan dengan Covid-19, maka Anda dipersilahkan untuk Bekerja. Kami menantikan kehadiran anda :)';

  String _statusSick =
      'Dari laporan anda, anda diketahui memiliki gejala Covid-19, maka anda '
      'tidak diperkenankan masuk bekerja pada hari ini, silahkan anda bisa bekerja 3 hari kemudian.';

  List<CheckBoxCondition> _checkList = CheckBoxCondition.getCOnditions();
  List _conditions = [];

  Color _fgColor = Colors.green;
  Color _bgColor = Colors.red;

  bool _changeColor = true;

  _isColorChange() {
    setState(() {
      _changeColor = !_changeColor;
    });
  }

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
      print(_visible);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FormField(
            key: _formKey,
            builder: (FormFieldState<bool> state) {
              return Column(
                children: [
                  Text(
                    "Hai, Bagaimana Kabarmu Hari Ini?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  buildCondition(),
                ],
              );
            },
          ),
          _rvaluegroup != -1
              ? SizedBox()
              : Text(
                  "Please Select One",
                  style: TextStyle(color: Colors.red),
                ),
          _submitButton(),
        ],
      ),
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
                  _condition.index == 1 ? _conditions.clear() : null;
                  // _rvaluegroup == 1 ? _conditions.clear() : null;
                });
              },
            );
          },
        ),
        _bergejala ? _buildBergejala() : SizedBox(),
      ],
    );
  }

  Container _buildBergejala() {
    return Container(
      color: Colors.amberAccent,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: _checkList.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                value: _checkList[index].isCheck,
                title: Text(_checkList[index].title),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  setState(
                    () {
                      _checkList[index].isCheck = value!;
                      _checkCondition(index);
                      // _rvaluegroup == 2
                      //     ? _checkList[index].isCheck
                      //         ? _conditions.add(
                      //             _checkList[index].title)
                      //         : _conditions.remove(
                      //             _checkList[index].title)
                      //     : _conditions.clear();
                      print(_conditions.join(', '));
                    },
                  );
                },
              );
            },
          ),
          _conditions.isEmpty
              ? Text(
                  "Please Select One",
                  style: TextStyle(color: Colors.red),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  void _checkCondition(int index) {
    if (_rvaluegroup == 2 && _checkList[index].isCheck) {
      _conditions.add(_checkList[index].title);
    } else if (_checkList[index].isCheck == false) {
      _conditions.remove(_checkList[index].title);
    }
  }

  Widget _submitButton() {
    return _visible
        ? CircularProgressIndicator()
        : MaterialButton(
            color: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {
              /// todo
              // getPortalStatus();
              _rvaluegroup != -1
                  ? isPortalUpdated().then(
                      (value) => value
                          ? showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text('Sudah Input'),
                                );
                              })
                          : submitPortal(),
                    )
                  : print('tidak di upload');
            },
            child: Text('SUBMIT'),
          );
  }

  submitPortal() {
    if (_rvaluegroup == 1 || _conditions.isNotEmpty) {
      loadProgress();
      doSubmit();

      // setState(() {});
    }
    print('nilainya ' + _rvaluegroup.toString());
    print('kondisinya ' + _conditions.toString());
  }

  Future doSubmit() async {
    //
    // Uri url = Uri.parse("http://10.0.2.2/android/pegawai/upload_portal.php");

    // Uri url = Uri.parse(
    //     "http://13e92982e22739.localhost.run/android/pegawai/upload_portal.php");

    DateTime _time = DateTime.now();
    String _formattedTime = DateFormat('yyMMddHHmmss').format(_time);
    String _formattedDate = DateFormat('yyMMdd').format(_time);
    String _user = 'hmm';
    await UserSecureStorage.getUsername().then((value) {
      setState(() {
        _user = value!;
      });
    });
    String _newUserId = _user.replaceAll(RegExp('"'), '');

    print(_formattedDate + _kondisi);
    print('id nya adalah : ' + _user.replaceAll(RegExp('"'), ''));

    final response = await http.post(
      Uri.parse("${url}upload_portal.php"),
      body: {
        'id': _newUserId,
        'tanggal': _formattedDate,
        'waktu': _formattedTime,
        'kondisi': _rvaluegroup == 1 ? 'Sehat' : _conditions.join(', '),
      },
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      loadProgress();
      if (response.body.contains(RegExp('Duplicate'))) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Sudah Input'),
              );
            });
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            content: Text(
                'Sukses melakukan update portal. Terima kasih telah melaporkan kondisi kesehatan anda hari ini. ${_rvaluegroup == 1 ? _statusFit : _statusSick}'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    } else {
      print('status error');
    }
  }
}
