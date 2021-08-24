import 'dart:convert';

import 'package:alpha/page/form_kaizen.dart';
import 'package:alpha/page/portal/absensi_portal.dart';
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
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YMMI Connect"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FutureBuilder(
              future: fetchUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                    maxRadius: 25,
                    backgroundImage: NetworkImage(
                        'http://192.168.43.113/android/pegawai/$imagePath'),
                  );
                }
                return Text('error');
              },
            ),
          ),
        ],
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
                route: const presention(),
                text: 'Detail Kehadiran'),
            _buildDivider(),
            _buildListTile(
                context: context, route: const SlipGaji(), text: 'Slip Gaji'),
            _buildDivider(),
            _buildListTile(
                context: context,
                route: const Diskusi(),
                text: 'Ruang Diskusi'),
            _buildDivider(),
            _buildListTile(context: context, route: Kaizen(), text: "Form Kaizen"),
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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // _buildImageSlideshow(),
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
                  // fetchUser();
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
        Icon(Icons.crop_square_sharp),
        // Icon(Icons.done),
        // Icon(Icons.done),
        // ListView.builder(
        //   itemCount: listAlbum.length,
        //     itemBuilder: (context, index) {
        //   return Column(
        //     children: [
        //       Image.asset(listAlbum[index]),
        //     ],
        //   );
        // })
      ],
    );
  }

  void _deleteUsername() {
    UserSecureStorage.deleteUsername();
  }
}

// class GetUserAvatar extends StatelessWidget {
//   const GetUserAvatar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRect(
//       child: Image.network(albumSlide.imageUrl),
//     );
//   }
// }

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
