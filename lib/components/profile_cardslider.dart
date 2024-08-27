import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// https://pub.dev/packages/carousel_slider
import '../utils/cardStyles.dart';


final List<Widget> imageSliders = List.generate(5, (index) => Container(
  width: 320.0,
  height: 70.0,
  margin: EdgeInsets.all(5.0),
  child: ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    child: Image.asset('assets/banners/banner${index}.jpg', fit: BoxFit.fill),
  ),
));


class CardSlider extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return Container(
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
