import 'package:alpha/page/slide_image.dart';
import 'package:flutter/material.dart';

class CustomSlideShow extends StatelessWidget {
  final List<AlbumSlide> albumSlide;

  const CustomSlideShow({Key? key, required this.albumSlide}) : super(key: key);

  Column _createViewItem(AlbumSlide albumSlide, BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350,
          // height: 300,
          padding: EdgeInsets.only(right: 25),
          child: Column(
            children: [
              Image.network(albumSlide.imageUrl),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        itemCount: albumSlide.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _createViewItem(albumSlide[index], context);
        },
      ),
    );
  }
}
