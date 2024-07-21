import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class FortuneImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  FortuneImageSlider({required this.imageUrls});

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
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Image.network(url, fit: BoxFit.cover),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: FortuneBar(
            selected: _controller.stream,
            items: widget.imageUrls.map((url) {
              return FortuneItem(
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