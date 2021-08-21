import 'dart:convert';

import 'package:alpha/page/slide_image.dart';
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

// class SlideAlbum{
//   final String id;
// }
