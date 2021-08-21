import 'dart:convert';

import 'package:alpha/page/absensi_portal.dart';
import 'package:alpha/page/diskusi.dart';
import 'package:alpha/page/home_page/custom_album_view.dart';
import 'package:alpha/page/konsultasi_hr.dart';
import 'package:alpha/page/lapor_absen.dart';
import 'package:alpha/page/slide_image.dart';
import 'package:alpha/page/slip_gaji.dart';
import 'package:alpha/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;

import '../../db_helper/album.dart';

class HomePage extends StatefulWidget {
  // final List <AlbumSlide> albumSlide;

  // HomePage(this.albumSlide);
  //
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YMMI Connect"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("YMMI CONNECT"),
            ),
            _buildListTile(
                context: context,
                route: const AbsensiPortal(),
                text: 'Absensi Portal'),
            _buildDivider(),
            _buildListTile(
                context: context,
                route: const LaporAbsen(),
                text: 'Laporan Tidak Hadir'),
            _buildDivider(),
            _buildListTile(
                context: context, route: const SlipGaji(), text: 'Slip Gaji'),
            _buildDivider(),
            _buildListTile(
                context: context,
                route: const Diskusi(),
                text: 'Ruang Diskusi'),
            _buildDivider(),
            _buildListTile(
                context: context,
                route: const Konsultasi(),
                text: 'Konsultasi HR'),
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _deleteUsername();
                  });
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Log Out'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            _buildImageSlideshow(),
            FutureBuilder<List<AlbumSlide>>(
              future: fetchAlbum(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<AlbumSlide> _albumSlide = snapshot.data!;
                    if (_albumSlide.length == 0) {
                      return Text("Kosong");
                    } else {
                      return CustomSlideShow(albumSlide: _albumSlide);
                    }
                  } else {
                    return Text(snapshot.error.toString());
                  }
                }
                return CircularProgressIndicator();
              },
            ),
            MaterialButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                print('widgetnya $AlbumSlide');
                fetchAlbum();
              },
              child: Text(
                'Get Images',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageSlideshow _buildImageSlideshow() {
    List<AlbumSlide> _albumSlide;
    return ImageSlideshow(
      autoPlayInterval: 5000,
      isLoop: true,
      children: [
        Icon(Icons.done),
        Icon(Icons.done),
        Icon(Icons.done),
        Icon(Icons.done),
      ],
    );
  }

  void _deleteUsername() {
    UserSecureStorage.deleteUsername();
  }
}

_buildListTile(
    {required BuildContext context, required route, required String text}) {
  return ListTile(
    title: Text(text),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => route,
        ),
      );
    },
  );
}

Divider _buildDivider() {
  return const Divider(
    height: 1,
    indent: 20,
    endIndent: 100,
    color: Colors.black38,
  );
}
