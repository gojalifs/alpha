import 'package:alpha/page/home_page/home_page.dart';
import 'package:alpha/page/welcome/welcome_page.dart';
import 'package:alpha/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> _isSeen() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    bool _seen = _pref.getBool('isSeen') ?? false;
    return _seen;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isSeen(),
      builder: (context, snapshot) {
        var seen = snapshot.data;
        return MaterialApp(
          title: "YMMI Connect",
          routes: routes,
          home: seen == true ? HomePage() : WelcomePage(),
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            backgroundColor: Colors.red,
            fontFamily: 'poppins',
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('id', 'ID'),
          ],
        );
      },
    );
  }
}

Container buildBg({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(173, 70, 137, 1),
          Color.fromRGBO(237, 92, 134, 1)
        ],
      ),
    ),
  );
}

Color builBgColor() {
  return Color(10);
}
