import 'package:alpha/utils/url.dart';
import 'package:alpha/page/portal/kehadiran_karyawan.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List _conditions = [];
List<CheckBoxCondition> _checkList = CheckBoxCondition.getCOnditions();

class Absence extends StatefulWidget {
  const Absence({Key? key}) : super(key: key);

  @override
  _AbsenceState createState() => _AbsenceState();
}

class _AbsenceState extends State<Absence> {
  String _dropDownValue = 'Sakit';
  List reasonAbsence = ["Sakit", "Izin", "Cuti Khusus", "Cuti Tahunan"];

  TextEditingController _waController = TextEditingController();
  final _sickFormKey = GlobalKey<FormState>();

  String? _inputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan Nomor Telepon';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("TIDAK MASUK"),
        DropdownButton<String>(
          value: _dropDownValue,
          onChanged: (String? newValue) {
            setState(() {
              _dropDownValue = newValue!;
            });
          },
          items: reasonAbsence
              .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                    child: Text(e),
                    value: e,
                  ))
              .toList(),
        ),
        _dropDownValue == reasonAbsence[0] ? _buildSick() : _buildCuti(),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            if (_sickFormKey.currentState!.validate()) {
              doUploadSick();
              print("Sukses");
            }
          },
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  _buildSick() {
    return Form(
      key: _sickFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("No. WhatsApp yang bisa dihubungi :"),
          Container(
            width: 250,
            child: TextFormField(
              validator: _inputValidator,
              controller: _waController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          buildBergejala(),
        ],
      ),
    );
  }

  TextEditingController _alasanController = TextEditingController();

  _buildCuti() {
    return Form(
      key: _sickFormKey,
      child: Column(
        children: [
          Text("Alasan"),
          Container(
            width: 250,
            child: TextFormField(
              controller: _alasanController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: _inputValidator,
            ),
          ),
        ],
      ),
    );
  }

  Future doUploadSick() async {
    // Uri url = Uri.parse("${url}tidakmasuk.php");

    DateTime _time = DateTime.now();
    String _formattedDate = DateFormat('yyMMdd').format(_time);
    String _user = 'hmm';
    await UserSecureStorage.getUsername().then((value) {
      setState(() {
        _user = value!;
      });
    });
    // String _newUserId = _user.replaceAll(RegExp('"'), '');

    final resp = await http.post(Uri.parse("${url}tidakmasuk.php"), body: {
      'id': _user,
      'tanggal': _formattedDate,
      'keterangan': _dropDownValue,
      'alasan': _dropDownValue == 'Sakit'
          ? _conditions.join(', ')
          : _alasanController.text,
      'wa': _waController.text,
    });
    print("alasannya $_dropDownValue");
    print(resp.body);
  }

  @override
  void dispose() {
    _waController.dispose();
    _alasanController.dispose();
    super.dispose();
  }
}

Container buildBergejala() {
  void _checkCondition(int index) {
    if (_checkList[index].isCheck) {
      _conditions.add(_checkList[index].title);
    } else {
      _conditions.clear();
    }
  }

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
