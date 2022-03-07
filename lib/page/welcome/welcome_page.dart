import 'package:alpha/login_page.dart';
import 'package:alpha/page/home_page/home_page.dart';
import 'package:alpha/routes.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "welcome",
              style: TextStyle(
                  fontSize: 35, color: Theme.of(context).primaryColor),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LandingPage();
                    },
                  ),
                );
              },
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
              shape: CircleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
              padding: EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  // const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  MaterialApp mainAppBuilder(Widget widget) {
    return MaterialApp(
      home: widget,
      routes: routes,
      title: "YMMI Connect",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'poppins',
        // scaffoldBackgroundColor: Color.fromRGBO(240, 240, 240, 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Aplikasi ini sangat powerful, berguna untuk :"),
            Text("BLABLABLA"),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FutureBuilder(
                          future:
                              getUser(), // a previously-obtained Future<String> or null
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              return mainAppBuilder(const HomePage());
                            } else {
                              return mainAppBuilder(const LoginPage());
                            }
                          },
                        );
                      },
                    ),
                  );
                });
              },
              child: Text("Agree"),
            ),
          ],
        ),
      ),
    );
  }

  Future getUser() async {
    final Future _user = UserSecureStorage.getUsername();
    return _user;
  }
}
