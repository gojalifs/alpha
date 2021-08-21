import 'package:flutter/material.dart';

class Diskusi extends StatefulWidget {
  const Diskusi({Key? key}) : super(key: key);

  @override
  _DiskusiState createState() => _DiskusiState();
}

class _DiskusiState extends State<Diskusi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Obrolan Grup'),
      ),
      body: Center(
        child: Text('Halaman Grup'),
      ),
    );
  }
}
