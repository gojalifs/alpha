import 'package:flutter/material.dart';

class Konsultasi extends StatefulWidget {
  const Konsultasi({Key? key}) : super(key: key);

  @override
  _KonsultasiState createState() => _KonsultasiState();
}

class _KonsultasiState extends State<Konsultasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi'),
      ),
      body: Center(
        child: Text('Halaman Konsultasi HR'),
      ),
    );
  }
}
