import 'dart:async';
import 'dart:convert';

import 'package:alpha/db_helper/album.dart';
import 'package:alpha/utils/url.dart';
import 'package:alpha/page/laporan_absensi/detail_model.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:alpha/page/dropdown_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';

class PresentionPage extends StatefulWidget {
  const PresentionPage({Key? key}) : super(key: key);

  @override
  _PresentionPageState createState() => _PresentionPageState();
}

class _PresentionPageState extends State<PresentionPage> {
  List<DetailKehadiran> _listOfTableRow = [];
  String? _selectedMonth, _selectedYear, _selectedMonthMMM = 'new';

  void formatDate(DateTime dateTime) {
    final DateFormat _monthFormatter = DateFormat('MM');
    final DateFormat _yearFormatter = DateFormat('yyyy');
    final DateFormat _mmmFormatter = DateFormat.MMMM('id-ID');
    setState(() {
      _selectedMonth = _monthFormatter.format(dateTime);
      _selectedYear = _yearFormatter.format(dateTime);
      _selectedMonthMMM = _mmmFormatter.format(dateTime);
    });
    print('date picked : $_selectedMonth, $_selectedYear, $_selectedMonthMMM');
  }
  // Future _reportFuture = getKehadiran();

  TextStyle _buildTextStyle() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  void initState() {
    super.initState();
    // getKehadiranCache().then((value) => _listOfTableRow = value);
    getKehadiran().then((value) {
      setState(() {
        _listOfTableRow = value;
      });
      print('valuenya $value');
    });
    formatDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Absensi'),
      ),
      body: Column(
        children: [
          // DropdownButton<String>(
          //   hint: Text("Pilih Periode"),
          //   value: dropDownMonth,
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       dropDownMonth = newValue!;
          //       getKehadiran().then((value) {
          //         setState(() {
          //           _listOfTableRow = value;
          //         });
          //         print('valuenya $value');
          //       });
          //     });
          //   },
          //   items: monthList
          //       .map<DropdownMenuItem<String>>(
          //         (e) => DropdownMenuItem<String>(
          //           child: Text(e),
          //           value: e,
          //         ),
          //       )
          //       .toList(),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     DatePicker.showDatePicker(
          //       context,
          //       currentTime: DateTime.now(),
          //       locale: LocaleType.id,
          //       onChanged: (date) {
          //         print(date);
          //       },
          //       onConfirm: (date) {
          //         formatDate(date);
          //         getKehadiran().then(
          //           (value) {
          //             setState(
          //               () {
          //                 _listOfTableRow = value;
          //               },
          //             );
          //           },
          //         );
          //       },
          //     );
          //   },
          //   child: Text(_month),
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.green,
          //     elevation: 1,
          //     // shape: RoundedRectangleBorder(
          //     //   borderRadius: BorderRadius.circular(20),
          //     // ),
          //   ),
          // ),

          ListView(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama : $user",
                        style: _buildTextStyle(),
                      ),
                      Text(
                        "ID : $id",
                        style: _buildTextStyle(),
                      ),
                    ],
                  ),
                  Hero(
                    tag: 'user_tag',
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("$url$imagePath"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Pilih Periode",
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showMonthPicker(
                          locale: Locale('id', 'ID'),
                          context: context,
                          initialDate: DateTime.now(),
                        ).then((value) {
                          formatDate(value!);
                          setState(
                            () {
                              getKehadiran().then(
                                (value) {
                                  _listOfTableRow = value;
                                },
                              );
                            },
                          );
                        });
                      },
                      child: Text(_selectedMonthMMM!),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 1,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: getKehadiran(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting) {
                      if (_listOfTableRow.length != 0) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(
                                label: Text("Tanggal"),
                              ),
                              DataColumn(
                                label: Text("Jam Masuk"),
                              ),
                              DataColumn(
                                label: Text("Jam Keluar"),
                              ),
                              DataColumn(
                                label: Text("Jam OT"),
                              ),
                            ],
                            rows: _listOfTableRow
                                .map(
                                  (e) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(e.tanggal),
                                      ),
                                      DataCell(
                                        Text(e.jamMasuk),
                                      ),
                                      DataCell(
                                        Text(e.jamKeluar),
                                      ),
                                      DataCell(
                                        Text(e.jamOT),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      } else {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Text(
                                    "Maaf, data tidak ditemukan. Silahkan cari perioded bulan lain"),
                                Text(
                                    '<Contoh data ada di bulan Agustus dan September>'),
                              ],
                            ),
                          ),
                        );
                      }
                    } else {
                      return Wrap(children: [
                        Center(child: CircularProgressIndicator())
                      ]);
                    }
                  }),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      // getKehadiran();
                      // getKehadiranCache();
                      setState(() {});
                      _getData();
                      print('data row $_listOfTableRow');
                      getKehadiran().then((value) {
                        setState(() {
                          _listOfTableRow = value;
                        });
                        print('valuenya $value');
                      });
                    },
                    color: Colors.amber,
                    child: Text("Reload Data"),
                  ),

                  // StreamBuilder(
                  //   stream: _getData(),
                  //   builder: (context, snapshot) {
                  //     List _list = [];
                  //     return Column(
                  //       children: _list.map((e) => Text('yo $e')).toList(),
                  //     );
                  //   },
                  // ),

                  ///TODO mumet
                  // FutureBuilder<http.Response>(
                  //     future: getKehadiranCache(),
                  //     builder: (context, snapshot) {
                  //       var data = jsonEncode(snapshot.data);
                  //       print('datanya + $data');
                  //       return Text(data.toString());
                  //     }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<DetailKehadiran>> getKehadiran() async {
    var _user = await UserSecureStorage.getUsername();
    var date = monthList.indexWhere((element) => element == dropDownMonth) + 1;

    print('date now $date');
    var resp = await http.get(Uri.parse(
        '${url}detail_kehadiran.php?id=$_user&tanggal=$_selectedMonth&year=$_selectedYear'));

    print('$_user $date $dropDownMonth $monthList');

    if (resp.statusCode == 200) {
      List data = jsonDecode(resp.body);
      print('respon dari ini adalaah $data');

      var detail = data.map((e) => DetailKehadiran.fomJson(e)).toList();
      print('detail yg di return $detail');
      return detail;
    } else
      throw Exception("An Error Happened");
  }

  Stream<FileResponse> _getData() {
    return DefaultCacheManager().getFileStream(
        '${url}detail_kehadiran.php?id=2210594',
        withProgress: true);
  }

  Future<List<DetailKehadiran>> getKehadiranCache() async {
    var _user = await UserSecureStorage.getUsername();
    var file = await DefaultCacheManager()
        .getSingleFile('${url}detail_kehadiran.php?id=$_user');

    // var file2 = DefaultCacheManager().getFileStream(
    //     '${url}detail_kehadiran.php?id=$_user',
    //     withProgress: true);
    // var data2 = jsonDecode(file2);
    // print('hasilnya ${http.Response.fromStream(file2)}');

    // if (await file.exists()) {
    var res = await file.readAsString();
    List data = jsonDecode(res);
    print('respon dari ini adalaah $data');

    return data.map((e) => DetailKehadiran.fomJson(e)).toList();
    // } else
    // throw Exception("An Error Happened");
  }
}
