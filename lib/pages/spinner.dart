import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';


class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late StreamController<int> controller;

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FortuneBar(
      selected: controller.stream,
      items: [
        FortuneItem(child: Text('Han Solo')),
        FortuneItem(child: Text('Yoda')),
        FortuneItem(child: Text('Obi-Wan Kenobi')),
      ],
    );
  }
}