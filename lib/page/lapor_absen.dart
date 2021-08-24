import 'package:flutter/material.dart';

class presention extends StatefulWidget {
  const presention({Key? key}) : super(key: key);

  @override
  _presentionState createState() => _presentionState();
}

class _presentionState extends State<presention> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Absen'),
      ),
      body: Center(
        child: Text('Halaman Lapor Absensi'),
      ),
    );
  }
}
