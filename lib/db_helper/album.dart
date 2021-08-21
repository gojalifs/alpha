import 'dart:convert';

import 'package:alpha/page/slide_image.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<List<AlbumSlide>> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http://192.168.43.113/android/pegawai/fetch_image.php'));

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    // listAlbum = List.from(data);
    // print('image list 1 $listAlbum');
    print('data $data');

    List spacecrafts = json.decode(response.body);

    return data
        .map((spacecraft) => new AlbumSlide.fromJSON(spacecraft))
        .toList();
  } else {
    throw Exception('We were not able to successfully download the json data.');
  }
}

var imagePath, id;

Future fetchUser() async {
  var _user = await UserSecureStorage.getUsername();

  var url = Uri.parse(
      'http://192.168.43.113/android/pegawai/fetch_user.php?id=$_user');

  final response = await http.get(url);

  // final resp = await http.post(
  //   url,
  //   body: {'id': id},
  // );

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    print('tipe data json ${data[0]['avatar']}');

    imagePath = data[0]['avatar'];

    return imagePath;
  }
}

// class SlideAlbum{
//   final String id;
// }
