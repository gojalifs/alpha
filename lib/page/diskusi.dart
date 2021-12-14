import 'package:flutter/material.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key? key}) : super(key: key);

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Obrolan Grup'),
      ),
      body: Center(
        // child: Text('Halaman Grup'),
        child: Image.asset('images/UnderConstruct.jpg'),
      ),
    );
  }
}
