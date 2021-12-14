import 'package:alpha/utils/url.dart';

class AlbumSlide {
  final String imageUrl;

  AlbumSlide({required this.imageUrl});

  factory AlbumSlide.fromJSON(Map<String, dynamic> jsonData) =>
      AlbumSlide(imageUrl: url + jsonData['img_dir']);
}
