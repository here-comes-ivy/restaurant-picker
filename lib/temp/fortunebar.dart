import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';


class FortuneImageSlider extends StatefulWidget {
  final List<String> imageUrls = [
    "https://unsplash.com/photos/two-person-sitting-on-bar-stool-chair-in-front-of-bar-front-desk-8x_fFNrmeDk",
    "https://unsplash.com/photos/brown-themed-bar-GXXYkSwndP4",
    "https://unsplash.com/photos/mens-sitting-green-chair-reading-newspaper-4UGlx_OXqgs",
  ];

  //const FortuneImageSlider({super.key, required this.imageUrls});

  @override
  _FortuneImageSliderState createState() => _FortuneImageSliderState();
}

class _FortuneImageSliderState extends State<FortuneImageSlider> {
  int _currentIndex = 0;
  late StreamController <int> _controller;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              _controller.add(index);
            },
          ),
          items: widget.imageUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Image.network(url, fit: BoxFit.cover),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: FortuneBar(
            selected: _controller.stream,
            items: widget.imageUrls.map((url) {
              return const FortuneItem(
                child: SizedBox.shrink(),
                style: FortuneItemStyle(
                  color: Colors.blue,
                  borderWidth: 0,
                ),
              );
            }).toList(),
            onFling: () {},
          ),
        ),
      ],
    );
  }
}