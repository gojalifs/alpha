import 'dart:convert';

import 'package:alpha/db_helper/album.dart';
import 'package:alpha/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({Key? key}) : super(key: key);

  @override
  _ConsultationPageState createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  TextEditingController _controller = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  String _problem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Hai Fajar 🤗',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Jika kamu punya masalah, silahkan hubungi kami saja yaaa 😊',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ketik Masalahmu Di Sini...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mohon ketikkan sesuatu tentang masalah anda";
                      }
                    },
                    onChanged: (value) {
                      _problem = value;
                    },
                  ),
                  MaterialButton(
                    onPressed: () {
                      /// TODO validate first
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          _sendConsultationData(_problem);
                        }
                      }
                    },
                    color: Colors.amber,
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _sendConsultationData(String data) async {
    var response = await http.post(Uri.parse('${url}consult.php'), body: {
      "id": id,
      "problem": _problem,
    });

    var result = jsonDecode(response.body);
    print(result);

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("Sukses"),
              content: Text(
                  "Berhasil disubmit, kami akan segera menghubungi anda secepatnya. Mohon untuk menunggu sejenak"),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
