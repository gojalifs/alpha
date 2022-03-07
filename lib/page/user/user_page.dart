import 'dart:convert';

import 'package:alpha/db_helper/album.dart';
import 'package:alpha/page/user/user_model.dart';
import 'package:alpha/utils/url.dart';
import 'package:alpha/login_page.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<UserDataModel> _userData = [];
  Map<String, dynamic> _userDataMap = {};
  // List _detailList = [
  //   'ID',
  //   'Nama',
  //   'Status Karyawan',
  //   'Departemen',
  //   'Sub Departemen',
  //   'Gaji Pokok',
  //   'Tanggal Join',
  //   'No. Hp',
  //   'Tanggal Lahir',
  //   'Jenis Kelamin',
  //   'Alamat',
  // ];

  @override
  void initState() {
    super.initState();
    fetchUser().then((value) {
      setState(() {
        _userData = value;
        // _userDataMap = value;
      });
    });
    _getUser();
  }

  void printelement() {
    var anu = _userDataMap.keys;
    for (var key in anu) {
      print('key $key');
    }
  }

  void _deleteUsername() async {
    UserSecureStorage.deleteUsername();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool('isSeen', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Hero(
                  tag: 'user_tag',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                      imageUrl: '$url$imagePath',
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: _userData
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                _buildUserData("Nama", e.name),
                                Divider(),
                                _buildUserData('No. ID', e.id),
                                Divider(),
                                _buildUserData("Alamat", e.address),
                                Divider(),
                                _buildUserData("No. Hp", e.phone),
                                Divider(),
                                _buildUserData("Tanggal Lahir", e.birth),
                                Divider(),
                                _buildUserData("Departemen", e.dept),
                                Divider(),
                                _buildUserData("Sub Dept.", e.subGrup),
                                Divider(),
                                _buildUserData("Status Kerja", e.status),
                                Divider(),
                                _buildUserData("Tanggal Join", e.joinDate),
                                Divider(),
                                _buildUserData("Gaji Pokok", e.salary),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              // MaterialButton(
              //   onPressed: () {
              //     printelement();
              //   },
              //   child: Text("Print"),
              // ),
              MaterialButton(
                onPressed: () {
                  _deleteUsername();
                },
                child: Text("Log Out"),
                color: Colors.red.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildUserData(String key, var e) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 1, child: Text(key)),
        Expanded(
          flex: 1,
          child: Text(
            e.toString(),
            style: TextStyle(
              color: Colors.black54,
              fontSize: 17,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Future _getUser() async {
    var _user = await UserSecureStorage.getUsername();

    final response = await http.get(Uri.parse('${url}get_user.php?id=$_user'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // setState(() {
      //   _userDataMap = data;
      // });

      // print('data get user $_userDataMap');

      final List<UserDataModel> userData =
          data.map((e) => UserDataModel.fromJson(e)).toList();

      return userData;
    } else {
      print("response error" + response.statusCode.toString());
    }
  }
}
