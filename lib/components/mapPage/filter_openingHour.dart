import 'package:flutter/material.dart';

/// Flutter code sample for [ActionChoice].


class OpeningHourFilter extends StatefulWidget {
  const OpeningHourFilter({super.key});

  @override
  State<OpeningHourFilter> createState() => _OpeningHourFilterState();
}

class _OpeningHourFilterState extends State<OpeningHourFilter> {
  int? _value = 1;

  @override
  Widget build(BuildContext context) {

    return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Opening Hour'),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 5.0,
              children: [
                
                ChoiceChip(
                    label: Text('Anytime'),
                    selected: _value == 1,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? 1 : null;
                      });
                    },
                  ),
                                  ChoiceChip(
                    label: Text('Opening Now'),
                    selected: _value == 2,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? 2 : null;
                      });
                    },
                  ),
                  
              ],
            ),
          ],
        ),
      
    );
  }
}
