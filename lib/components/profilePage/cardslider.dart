import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider_plus/carousel_slider_plus.dart';// https://pub.dev/packages/carousel_slider


class CardSlider extends StatelessWidget {

final List<Widget> imageSliders = List.generate(5, (index) => Container(
  width: 320.0,
  height: 70.0,
  margin: EdgeInsets.all(5.0),
  child: ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    child: Image.asset('assets/banners/banner$index.jpg', fit: BoxFit.fill),
  ),
));


  @override
    Widget build(BuildContext context) {
      if (imageSliders.isEmpty) {
      return Container(); 
    }
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 250.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 320/70 ,
            enlargeCenterPage: true,
          ),
          items: imageSliders,
        ),
      );
    }
}
