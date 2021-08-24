import 'package:flutter/material.dart';

enum Condition { bergejala, tidakBergejala }

class AbsensiPortal extends StatefulWidget {
  const AbsensiPortal({Key? key}) : super(key: key);

  @override
  _AbsensiPortalState createState() => _AbsensiPortalState();
}

class _AbsensiPortalState extends State<AbsensiPortal> {
  final _formKey = GlobalKey<FormState>();
  final _formWFOKey = GlobalKey<FormState>();

  int showFormIndex = 0;

  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          'Konfirmasi Kehadiran Karyawan',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:
          // AlertDialog(
          //   title: Text('Apakah anda akan datang bekerja?'),
          //   actions: [
          //     MaterialButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //         _buildRow(context);
          //       },
          //       child: Text("YA"),
          //     ),
          //     MaterialButton(
          //       onPressed: () {},
          //       child: Text("TIDAK"),
          //     ),
          //     MaterialButton(
          //       onPressed: () {},
          //       child: Text("SAH"),
          //     ),
          //   ],
          // ),
          SafeArea(
        child: Column(
          children: [
            _buildRow(context),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Card(
                elevation: 7,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Form(
                      child: Column(
                        children: [
                          showFormIndex == 1
                              ? _showWFO()
                              : showFormIndex == 2
                                  ? _showWFH()
                                  : showFormIndex == 3
                                      ? _showAbsent()
                                      : SizedBox(),
                          MaterialButton(
                            onPressed: () {
                              print(showFormIndex);
                            },
                            // child: Text('cek'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// radio button
  Condition? _condition = Condition.tidakBergejala;
  bool _bergejala = false;

  _showWFO() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Hai, Bagaimana Kabarmu Hari Ini?",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          RadioListTile(
            title: Text("Sehat Tidak Bergejala"),
            value: Condition.tidakBergejala,
            groupValue: _condition,
            onChanged: (Condition? value) {
              setState(() {
                _condition = value;
                _bergejala = false;
              });
            },
          ),
          RadioListTile(
            title: Text("Bergejala"),
            value: Condition.bergejala,
            groupValue: _condition,
            onChanged: (Condition? value) {
              setState(() {
                _condition = value;

                _bergejala = true;
              });
            },
          ),
          _bergejala
              ? Container(
                  color: Colors.amberAccent,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text("Demam > 37.3 C"),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _checked,
                          onChanged: (bool? value) {
                            setState(() {
                              _checked = value!;
                            });
                          })
                    ],
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  _showWFH() {
    return Column(
      children: [
        Text("WFH"),
      ],
    );
  }

  _showAbsent() {
    return Column(
      children: [
        Text("TIDAK MASUK"),
      ],
    );
  }

  Row _buildRow(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
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
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Divider(
                          height: 5,
                          color: Colors.white,
                        ),
                        Text(
                          "Apakah Anda Akan Datang Bekerja Hari ini?",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                setState(
                                  () {
                                    showFormIndex = 1;
                                    print(showFormIndex);
                                  },
                                );
                              },
                              child: Text("YA"),
                              color: Colors.purple,
                            ),
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  showFormIndex = 2;
                                  print(showFormIndex);
                                });
                              },
                              child: Text("TIDAK"),
                              color: Colors.purple,
                            ),
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  showFormIndex = 3;
                                  print(showFormIndex);
                                });
                              },
                              child: Text("SAH"),
                              color: Colors.purple,
                            )
                          ],
                        )
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
