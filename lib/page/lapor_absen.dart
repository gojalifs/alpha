import 'package:flutter/material.dart';

class LaporAbsen extends StatefulWidget {
  const LaporAbsen({Key? key}) : super(key: key);

  @override
  _LaporAbsenState createState() => _LaporAbsenState();
}

class _LaporAbsenState extends State<LaporAbsen> {
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
