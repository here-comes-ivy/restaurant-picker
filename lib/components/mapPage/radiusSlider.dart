import 'package:flutter/material.dart';

class RadiusSlider extends StatefulWidget {
  const RadiusSlider({super.key});

  @override
  State<RadiusSlider> createState() => _RadiusSliderState();
}

class _RadiusSliderState extends State<RadiusSlider> {
  int radius = 3;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Radius',
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.deepOrangeAccent,
              thumbColor: Colors.deepOrangeAccent,
              overlayColor: Colors.deepOrangeAccent.withOpacity(0.4),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
            ),
            child: Slider(
              value: radius.toDouble(),
              min: 1.0,
              max: 20.0,
              divisions: 19,
              label: '$radius km',
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
