import 'dart:io';

import 'package:alpha/page/home_page/home_page.dart';
import 'package:alpha/login_page.dart';
import 'package:alpha/routes.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

  ///delete it
  HttpOverrides.global = new MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'YMMI Connect';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      // Scaffold(
      //   appBar: AppBar(
      //     title: Text('New'),
      //   ),
      // ),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: routes,
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}


/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  MaterialApp mainAppBuilder(Widget widget) {
    return MaterialApp(
      home: widget,
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'ubuntu',
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder(
        future: user(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return mainAppBuilder(const HomePage());
          } else {
            return mainAppBuilder(const LoginPage());
          }
        },
      ),
    );
  }
}
Future user() async {
  final Future _user = UserSecureStorage.getUsername();
  return _user;
}

/// delete it
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}