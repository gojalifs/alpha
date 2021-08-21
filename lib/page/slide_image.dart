import 'package:flutter/material.dart';

class AlbumSlide {
  final String imageUrl;

  AlbumSlide({required this.imageUrl});

  factory AlbumSlide.fromJSON(Map<String, dynamic> jsonData){
    return AlbumSlide(imageUrl: 'http://192.168.43.113/android/pegawai/' + jsonData['img_dir']);
  }
}

// var listAlbum = [];
