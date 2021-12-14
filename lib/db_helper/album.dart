import 'dart:convert';

import 'package:alpha/page/user/user_model.dart';
import 'package:alpha/utils/url.dart';
import 'package:alpha/page/slide_image.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List<AlbumSlide>> fetchAlbum() async {
  final response = await http.get(Uri.parse('${url}fetch_image.php'));

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    // listAlbum = List.from(data);
    // print('image list 1 $listAlbum');
    print('data $data');

    // List spacecrafts = json.decode(response.body);

    return data
        .map((albumImage) => new AlbumSlide.fromJSON(albumImage))
        .toList();
  } else {
    throw Exception('We were not able to successfully download the json data.');
  }
}

var imagePath, user, dept;
String id = 0.toString();

Future fetchUser() async {
  var _user = await UserSecureStorage.getUsername();

  final response = await http.get(Uri.parse('${url}fetch_user.php?id=$_user'));

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    // print('tipe data json ${data[0]['avatar']}');
    // print('nama dari json ${data[0]['name']}');

    imagePath = data[0]['avatar'];
    id = data[0]['id'];
    user = data[0]['name'];
    dept = data[0]['dept'];
    print('data $data');

    // print(imagePath);
    final List<UserDataModel> userData =
        data.map((e) => UserDataModel.fromJson(e)).toList();

    return userData;
  } else {
    print("response error" + response.statusCode.toString());
  }
}

DateTime _time = DateTime.now();
String _formattedDate = DateFormat('yyMMdd').format(_time);

Future<bool> isPortalUpdated() async {
  // Uri url = Uri.parse(
  //     "http://192.168.43.113/android/pegawai/get_portal_status.php?id=$id&date=$_formattedDate");

  final resp = await http.get(
      Uri.parse("${url}get_portal_status.php?id=$id&date=$_formattedDate"));
  // print(id+_formattedDate);

  // print('status portalnya '+resp.body);
  var data = jsonDecode(resp.body);
  // print('valuenya' + data['value'].toString());
  if (data['value'] == 1) {
    print(data['message']);
    return true;
  } else
    return false;
}
