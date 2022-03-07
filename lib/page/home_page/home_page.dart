import 'package:alpha/page/home_page/menu.dart';
import 'package:alpha/page/leave_page/paid_leave_page.dart';
import 'package:alpha/utils/url.dart';
import 'package:alpha/page/diskusi.dart';
import 'package:alpha/page/kaizen/form_kaizen.dart';
import 'package:alpha/page/consultation/hr_consultation.dart';
import 'package:alpha/page/laporan_absensi/laporan_absen.dart';
import 'package:alpha/page/portal/kehadiran_karyawan.dart';
import 'package:alpha/page/salary/salary_page.dart';
import 'package:alpha/page/slide_image.dart';
import 'package:alpha/page/user/user_page.dart';
import 'package:alpha/utils/notification.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shimmer/shimmer.dart';

import '../../db_helper/album.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AlbumSlide> _albumSlide = [];

  FutureBuilder _slideShowBuilder() {
    return FutureBuilder(
      future: fetchMenu(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ImageSlideshow(
              autoPlayInterval: 5000,
              isLoop: true,
              children: _albumSlide
                  .map((e) => Container(
                        child: CachedNetworkImage(
                          imageUrl: e.imageUrl,
                        ),
                      ))
                  .toList(),
            );
          } else {
            return Container(
                color: Colors.red,
                height: 100,
                child: Text(snapshot.error.toString()));
          }
        }
        // return CircularProgressIndicator();
        return SizedBox(
          width: 200.0,
          height: 100.0,
          child: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: Container(),
          ),
        );
      },
    );
  }

  // FutureBuilder<List<Menu>> _buildMenuDynamically() {
  //   return FutureBuilder<List<Menu>>(
  //     future: fetchMenu(),
  //     builder: (context, snapshot) {
  //       //   return Text("ANU");
  //       // })
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         if (snapshot.hasData) {
  //           return Container(
  //             child: GridView.builder(
  //                 primary: false,
  //                 // padding: EdgeInsets.only(left: 30, right: 30),
  //                 shrinkWrap: true,
  //                 itemCount: snapshot.data?.length,
  //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 3,
  //                   mainAxisSpacing: 20,
  //                   crossAxisSpacing: 10,
  //                 ),
  //                 itemBuilder: (context, index) {
  //                   return InkWell(
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) {
  //                             switch (index) {
  //                               case 0:
  //                                 return AbsensiPortal();
  //                                 break;
  //                               case 1:
  //                                 return PresentionPage();
  //                                 break;
  //                               case 2:
  //                                 return SalaryPage();
  //                                 break;
  //                               case 3:
  //                                 return DiscussionPage();
  //                                 break;
  //                               case 4:
  //                                 return KaizenFormPage();
  //                                 break;
  //                               case 5:
  //                                 return ConsultationPage();
  //                                 break;
  //                               case 6:
  //                                 return PaidLeavePage();
  //                                 break;
  //                               default:
  //                                 return Container();
  //                                 break;
  //                             }
  //                           },
  //                         ),
  //                       );
  //                     },
  //                     child: Card(
  //                       elevation: 2,
  //                       color: Colors.white70,
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Flexible(
  //                             flex: 3,
  //                             child: CachedNetworkImage(
  //                               imageUrl: "$url${snapshot.data?[index].icon}",
  //                               // width: 50,
  //                             ),
  //                           ),
  //                           Flexible(
  //                             flex: 2,
  //                             child: Text(
  //                               snapshot.data![index].title,
  //                               style: TextStyle(
  //                                 fontSize: 13,
  //                               ),
  //                               maxLines: 2,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //           );
  //         } else
  //           return Text(snapshot.error.toString());
  //       } else
  //         return SizedBox(
  //           width: 200.0,
  //           height: 100.0,
  //           child: Shimmer.fromColors(
  //             baseColor: Colors.red,
  //             highlightColor: Colors.yellow,
  //             child: Container(),
  //           ),
  //         );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    fetchUser();
    fetchAlbum().then((value) {
      setState(() {
        _albumSlide = value;
      });
    });

    NotificationApi.init(initSchedule: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen((onClickedNotification));

  void onClickedNotification(String? payload) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => AbsensiPortal()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: FutureBuilder(
          future: fetchUser(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Text(
                "Welcome, $user",
                style: TextStyle(
                  color: Colors.black,
                ),
              );
            }
            return Text("Welcome");
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              fetchUser();
              // setState(() {});
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FutureBuilder(
                future: fetchUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Hero(
                          tag: 'user_tag',
                          child: CircleAvatar(
                            maxRadius: 30,
                            backgroundImage: NetworkImage('$url$imagePath'),
                          ),
                        ),
                      );
                    }
                    return Icon(Icons.person);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              _slideShowBuilder(),
              // SizedBox(
              //   height: 25,
              // ),
              // _buildMenuDynamically(),
              // MaterialButton(
              //   onPressed: () => NotificationApi.showNotification(
              //       title: 'Absen',
              //       body: "Sudahkan Anda Absen Portal Hari ini?",
              //       payload: "Sarah.abs"),
              //   child: Text("Show Notification"),
              //   color: Colors.amber,
              // ),
              // MaterialButton(
              //   onPressed: () {},
              //   child: Text("Scheduled Notification"),
              //   color: Colors.amber,
              // ),
              SizedBox(
                height: 25,
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                ),
                itemCount: mapAlbum.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            switch (index) {
                              case 0:
                                return AbsensiPortal();

                              case 1:
                                return PresentionPage();

                              case 2:
                                return SalaryPage();

                              case 3:
                                return DiscussionPage();
                              case 4:
                                return KaizenFormPage();
                              case 5:
                                return ConsultationPage();
                              default:
                                return PaidLeavePage();
                            }
                          },
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      color: Colors.white70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Image.asset(
                              mapAlbum.values.elementAt(index),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Text(
                              mapAlbum.keys.elementAt(index),
                              style: TextStyle(
                                fontSize: 13,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
