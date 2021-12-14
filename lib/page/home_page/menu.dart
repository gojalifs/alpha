import 'dart:convert';

import 'package:alpha/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Menu {
  final String title, icon;

  Menu({required this.title, required this.icon});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(title: json['title'], icon: json['icon']);
  }
}

class PanelButton {
  final String text;
  final Menu Function() onClick;

  PanelButton({required this.text, required this.onClick});
}

Future<bool> redirectTo({required BuildContext context, required route}) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  return true;
}

class Route {}

class PanelMenu extends StatelessWidget {
  final Menu menu;
  final void Function(Menu) onChange;

  const PanelMenu({Key? key, required this.menu, required this.onChange})
      : super(key: key);

  List<Widget> _buildMenuWidget() {
    final list = [
      PanelButton(
        text: '1',
        onClick: () => Menu(title: menu.title, icon: menu.icon),
      )
    ];

    return list
        .map((e) => Column(
              children: [
                MaterialButton(
                    onPressed: () => _raiseOnChange(menu), child: Text(e.text)),
              ],
            ))
        .toList();
  }

  void _raiseOnChange(Menu menu) {
    onChange(menu);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildMenuWidget(),
    );
  }
}

Future<List<Menu>> fetchMenu() async {
  final resp = await http.get(Uri.parse('$url/fetch_home_menu.php'));

  if (resp.statusCode == 200) {
    List data = jsonDecode(resp.body);
    var menu = data.map((e) => Menu.fromJson(e)).toList();
    return menu;
  } else
    throw Exception('We were not able to successfully download the json data.');
}

var mapAlbum = {
  'Absensi Portal': 'images/main_menu/absensi.png',
  'Detail Kehadiran': 'images/main_menu/kehadiran.png',
  'Slip Gaji': 'images/main_menu/slip.png',
  'Ruang Diskusi': 'images/main_menu/group_chat.png',
  'Form Kaizen': 'images/main_menu/kaizen.png',
  'Konsultasi HR': 'images/main_menu/konsultasi_hr.png',
  'Ajukan Cuti': 'images/main_menu/leave.png'
};
