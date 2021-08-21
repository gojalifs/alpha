import 'dart:convert';

import 'package:alpha/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var _userController = TextEditingController();
  var _passController = TextEditingController();

  String id = '';
  String birth = '';
  String failLogin = '';

  @override
  Widget build(BuildContext context) {
    var _loginForm = Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                'YMMI Connect',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              controller: _userController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your ID';
                }
              },
              decoration: InputDecoration(
                labelText: "ID",
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLength: 7,
              onChanged: (value) {
                id = value;
              },
            ),
            TextFormField(
              controller: _passController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Birth';
                }
              },
              decoration: InputDecoration(
                suffixText: 'YYMMDD',
                labelText: "Birth",
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLength: 6,
              onChanged: (value) {
                birth = value;
              },
            ),
            // Login Button
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
              child: MaterialButton(
                onPressed: () {
                  if (_formKey.currentState != null) {
                    if (_formKey.currentState!.validate()) {
                      _doLogin();
                    } else {
                      Fluttertoast.showToast(msg: 'msg');
                    }
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Wrap(
          children: [
            Card(
              child: _loginForm,
            ),
          ],
        ),
      ),
    );
  }

  Future _doLogin() async {
    // untuk emulator
    Uri url = Uri.parse('http://10.0.2.2/android/pegawai/login.php');

    // untuk real device
    // Uri url = Uri.parse('http://192.168.43.113/android/pegawai/login.php');

    final resp = await http.post(url, body: {
      "id": id,
      "birth_date": birth,
    });

    final data = jsonDecode(resp.body);
    int value = data['value'];
    String message = data['message'];
    print("value status $value");

    if (value == 1) {
      await UserSecureStorage.setUsername(jsonEncode(id));

      Navigator.pushReplacementNamed(context, '/home');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } else {
      setState(() {
        failLogin = "No. ID atau Tanggal Lahir salah";
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(failLogin)));
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
