import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';



class RadiusSlider extends StatefulWidget {
  const RadiusSlider({super.key});

  @override
  State<RadiusSlider> createState() => _RadiusSliderState();
}

class _RadiusSliderState extends State<RadiusSlider> {

  double displayRadiusInKM = 3.0; 

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return FilterCard(
      title: 'Distance',
      cardChild:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.deepOrangeAccent,
              thumbColor: Colors.deepOrangeAccent,
              overlayColor: Colors.deepOrangeAccent.withOpacity(0.4),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
            ),
            child: Slider(
              value: displayRadiusInKM,
              min: 1.0,
              max: 10.0,
              divisions: 19,
              label: '${displayRadiusInKM.toStringAsFixed(1)} km',
              onChanged: (double newRadius) {
                setState(() {
                  filterProvider.updateRadius(newRadius); 
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
