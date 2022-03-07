import 'dart:convert';

import 'package:alpha/db_helper/album.dart';
import 'package:alpha/utils/url.dart';
import 'package:alpha/page/dropdown_month.dart';
import 'package:alpha/page/salary/salary_model.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class SalaryPage extends StatefulWidget {
  const SalaryPage({Key? key}) : super(key: key);

  @override
  _SalaryPageState createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  List<SalarySlipModel> _tableColumn = [];

  var formatCurrency = NumberFormat.simpleCurrency(name: "");
  String? _selectedMonth,
      _selectedYear,
      _selectedMonthMMM = DateTime.now().month.toString();

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

  @override
  void initState() {
    super.initState();

    formatDate(DateTime.now());
    getSalaryData().then((value) {
      setState(() {
        _tableColumn = value;
      });
      print('data table value nya $value');
    });
    print('data table nya $_tableColumn');

    print("tanggal dari format $dropDownMonth");

    // print(_tableMapColumn);
  }

  @override
  Widget build(BuildContext context) {
    var _totalIncome = 0;
    var _totalRedudance = 0;
    // CircleAvatar(
    //   backgroundImage: NetworkImage("$url$imagePath"),
    // ),
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "SLIP GAJI YMMI",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Container(
                  height: 75,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _headerID(label: 'Nama', detail: ': $user'),
                            _headerID(label: 'ID', detail: ': $id'),
                            _headerID(label: 'Dept.', detail: ': $dept'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Hero(
                            tag: 'user_tag',
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("$url$imagePath"),
                              minRadius: 75,
                              maxRadius: 125,
                            ),
                          ),
                        ),
                        //   ClipRRect(
                        // borderRadius: BorderRadius.circular(25),
                        // child: Image(
                        //   image: NetworkImage("$url$imagePath"),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ],
                  ),
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
                                getSalaryData().then((value) {
                                  setState(() {
                                    _tableColumn = value;
                                  });
                                });
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Text("Periode : "),
                //     DropdownButton(
                //       items: monthList
                //           .map((e) => DropdownMenuItem<String>(
                //                 child: Text(e),
                //                 value: e,
                //               ))
                //           .toList(),
                //       hint: Text("Pilih Periode"),
                //       value: dropDownMonth,
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           dropDownMonth = newValue!;
                //           getSalaryData().then((value) {
                //             setState(() {
                //               _tableColumn = value;
                //             });
                //           });
                //         });

                //         print('bulan $dropDownMonth');
                //       },
                //     ),
                //     DropdownButton(
                //       items: yearList
                //           .map((e) => DropdownMenuItem<String>(
                //                 child: Text(e),
                //                 value: e,
                //               ))
                //           .toList(),
                //       value: dropDownYear,
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           dropDownYear = newValue!;
                //           getSalaryData().then((value) {
                //             setState(() {
                //               _tableColumn = value;
                //             });
                //           });
                //         });

                //         print('tahunnya $dropDownYear');
                //       },
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: FutureBuilder(
                    future: getSalaryData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.waiting) {
                        if (_tableColumn.isNotEmpty) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  child: Container(
                                    // padding: const EdgeInsets.all(10),
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Pendapatan",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                        Divider(
                                          height: 20,
                                          thickness: 2,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: _tableColumn.map(
                                            (e) {
                                              var tunjanganLain = [
                                                e.otherBenefit
                                              ];
                                              var totalBenefit = 0;
                                              for (int i = 0;
                                                  i < tunjanganLain.length;
                                                  i++) {
                                                totalBenefit +=
                                                    tunjanganLain[i];
                                              }

                                              var income = [
                                                e.mainSalary,
                                                e.position,
                                                e.family,
                                                e.discipline,
                                                e.transport,
                                                e.shift,
                                                e.lunchBenefit,
                                                e.overtime,
                                                e.otherBenefit,
                                              ].reduce((value, element) =>
                                                  value + element);

                                              _totalIncome = income;

                                              print(income);
                                              // for (int i = 0;
                                              //     i < income.length;
                                              //     i++) {
                                              //   _totalIncome += income[i];
                                              // }

                                              print(tunjanganLain.toString() +
                                                  'total benefit ' +
                                                  totalBenefit.toString());
                                              return Container(
                                                // height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  children: [
                                                    _salaryDataCont(
                                                        label: "Gaji Pokok",
                                                        detail:
                                                            '${formatCurrency.format(e.mainSalary)}'),
                                                    _salaryDataCont(
                                                        label:
                                                            "Tunjangan Jabatan",
                                                        detail:
                                                            '${formatCurrency.format(e.position)}'),
                                                    _salaryDataCont(
                                                        label:
                                                            "Tunjangan Keluarga",
                                                        detail:
                                                            '${formatCurrency.format(e.family)}'),
                                                    _salaryDataCont(
                                                        label:
                                                            'Tunjangan Disiplin',
                                                        detail:
                                                            '${formatCurrency.format(e.discipline)}'),
                                                    _salaryDataCont(
                                                        label:
                                                            "Tunjangan Transport",
                                                        detail:
                                                            '${formatCurrency.format(e.transport)}'),
                                                    _salaryDataCont(
                                                        label:
                                                            'Tunjangan Shift',
                                                        detail:
                                                            '${formatCurrency.format(e.shift)}'),
                                                    _salaryDataCont(
                                                        label:
                                                            "Tunjangan Makan",
                                                        detail:
                                                            '${formatCurrency.format(e.lunchBenefit)}'),
                                                    _salaryDataCont(
                                                        label:
                                                            "Tunjangan Lembur",
                                                        detail:
                                                            '${formatCurrency.format(e.overtime)}'),
                                                    _salaryDataCont(
                                                        label: "Tunjangan Lain",
                                                        detail:
                                                            '${formatCurrency.format(totalBenefit)}'),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 40,
                                                              right: 40),
                                                      child: _salaryDataCont(
                                                          label:
                                                              "Insentif Pajak DTP",
                                                          detail:
                                                              '${formatCurrency.format(e.otherBenefit)}'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Total Pendapatan Rp"),
                                            Text(
                                              "${formatCurrency.format(_totalIncome)}",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Card(
                                  child: Container(
                                    // padding: const EdgeInsets.all(10),
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Potongan",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                        Divider(
                                          height: 20,
                                          thickness: 2,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: _tableColumn.map(
                                            (e) {
                                              var outcome = [
                                                e.assurance,
                                                e.jht,
                                                e.jp,
                                                e.bpjsMedic,
                                                e.spsi,
                                                e.lunchReduction,
                                                e.otherReduction
                                              ].reduce((value, element) =>
                                                  value + element);
                                              _totalRedudance = outcome;

                                              return Container(
                                                // height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  children: [
                                                    _salaryDataCont(
                                                        label: "Asuransi",
                                                        detail: formatCurrency
                                                            .format(
                                                                e.assurance)),
                                                    _salaryDataCont(
                                                        label: "BPJS-TK JHT",
                                                        detail: formatCurrency
                                                            .format(e.jht)),
                                                    _salaryDataCont(
                                                        label: "BPJS-TK JP",
                                                        detail: formatCurrency
                                                            .format(e.jp)),
                                                    _salaryDataCont(
                                                        label: "BPJS Kesehatan",
                                                        detail: formatCurrency
                                                            .format(
                                                                e.bpjsMedic)),
                                                    _salaryDataCont(
                                                        label: "SPSI",
                                                        detail: formatCurrency
                                                            .format(e.spsi)),
                                                    _salaryDataCont(
                                                        label: "Makan",
                                                        detail: formatCurrency
                                                            .format(e
                                                                .lunchReduction)),
                                                    _salaryDataCont(
                                                        label: "Potongan Lain",
                                                        detail: formatCurrency
                                                            .format(e
                                                                .otherReduction)),
                                                  ],
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Total Pengeluaran Rp"),
                                            Text(
                                              "${formatCurrency.format(_totalRedudance)}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Card(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Pendapatan Bersih "),
                                        Text(
                                          "Rp${formatCurrency.format(_totalIncome - _totalRedudance)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Text(
                                      'Data kosong, silahkan coba lagi dengan periode lain.'),
                                  Text(
                                      '<Contoh data ada di bulan Agustus dan September>'),
                                ],
                              ),
                            ),
                          );
                        }

                        // return DataTable(
                        //   columns: [
                        //     _buildDataColumn(name: 'ID'),
                        //     _buildDataColumn(name: 'status'),
                        //     _buildDataColumn(name: 'departemen'),
                        //     _buildDataColumn(name: 'Sub Grup'),
                        //     _buildDataColumn(name: 'Periode'),
                        //     _buildDataColumn(name: 'Gaji Pokok'),
                        //     _buildDataColumn(name: 'T. Jabatan'),
                        //     _buildDataColumn(name: 'T. Keluarga'),
                        //     _buildDataColumn(name: 'T. Disiplin'),
                        //   ],
                        //   rows: _tableColumn
                        //       .map(
                        //         (e) => DataRow(
                        //           cells: [
                        //             DataCell(Text(e.id)),
                        //             DataCell(Text(e.status)),
                        //             DataCell(Text(e.dept)),
                        //             DataCell(Text(e.subGroup)),
                        //             DataCell(Text(e.period)),
                        //             DataCell(Text(e.mainSalary)),
                        //             DataCell(Text(e.position)),
                        //             DataCell(Text(e.family)),
                        //             DataCell(Text(e.discipline)),
                        //           ],
                        //         ),
                        //       )
                        //       .toList(),
                        // );

                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    getSalaryData().then((value) {
                      setState(() {
                        _tableColumn = value;
                      });
                      print('_tablecolumn $value');
                    });
                  },
                  color: Colors.amber,
                  child: Text("Reload Data"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _salaryDataCont({required String label, required String detail}) {
    return Container(
      height: 22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rp "),
                Text(
                  detail,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _headerID({required String label, required String detail}) {
    return Container(
      height: 22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: _buildTextStyle(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              detail,
              style: _buildTextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
  }

  Future<List<SalarySlipModel>> getSalaryData() async {
    var _user = await UserSecureStorage.getUsername();

    var _month =
        monthList.indexWhere((element) => element == dropDownMonth) + 1;

    var _year = dropDownYear;

    print("Month $_month Year $_year");

    // var resp = await http.get(Uri.parse('${url}get_gaji.php?id=$_user'));
    var resp = await http.get(Uri.parse(
        '${url}get_gaji.php?id=$_user&month=$_selectedMonth&year=$_selectedYear'));

    if (resp.statusCode == 200) {
      // try {
      List data = jsonDecode(resp.body);

      final List<SalarySlipModel> salary =
          data.map((e) => SalarySlipModel.fromJson(e)).toList();
      print("salary nya : $salary");

      return salary;
    }
    throw Exception("Error Getting Data");
  }
}
