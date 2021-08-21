import 'package:flutter/material.dart';

class AbsensiPortal extends StatefulWidget {
  const AbsensiPortal({Key? key}) : super(key: key);

  @override
  _AbsensiPortalState createState() => _AbsensiPortalState();
}

class _AbsensiPortalState extends State<AbsensiPortal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absensi Portal'),
      ),
      body: Center(
        child: Text('Halaman Absensi'),
      ),
    );
  }
}
