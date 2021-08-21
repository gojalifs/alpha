import 'package:flutter/material.dart';

class SlipGaji extends StatefulWidget {
  const SlipGaji({Key? key}) : super(key: key);

  @override
  _SlipGajiState createState() => _SlipGajiState();
}

class _SlipGajiState extends State<SlipGaji> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slip Gaji'),
      ),
      body: Center(
        child: Text('Halaman Slip Gaji'),
      ),
    );
  }
}
