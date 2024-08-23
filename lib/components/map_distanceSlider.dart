import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DistanceSlider extends StatefulWidget {
  const DistanceSlider({super.key});

  @override
  State<DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {

  int radius = 3;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrangeAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Distance',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                'kilometer',
              )
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              inactiveTrackColor: Color(0xFF8D8E98),
              activeTrackColor: Colors.white,
              overlayColor: Color(0x29EB1555),
              thumbShape:
                  RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape:
                  RoundSliderOverlayShape(overlayRadius: 30.0),
            ),
            child: Slider(
              value: radius.toDouble(),
              min: 0.0,
              max: 20.0,
              label: 'Kilometer',
              onChanged: (double newValue) {
                setState(() {
                  radius = newValue.round();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}