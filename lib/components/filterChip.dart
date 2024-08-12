import 'package:flutter/material.dart';

enum HourOptions { Anytime, OpenNow, OpenOn }

class OpeningHourFilter extends StatefulWidget {
  const OpeningHourFilter({super.key});

  @override
  State<OpeningHourFilter> createState() => _OpeningHourFilterState();
}

class _OpeningHourFilterState extends State<OpeningHourFilter> {
  Set<HourOptions> filters = <HourOptions>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Opening Hours', style: textTheme.labelLarge),
          const SizedBox(height: 5.0),
          Wrap(
            spacing: 5.0,
            children: HourOptions.values.map((HourOptions exercise) {
              return FilterChip(
                label: Text(exercise.name),
                selected: filters.contains(exercise),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filters.add(exercise);
                    } else {
                      filters.remove(exercise);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Looking for: ${filters.map((HourOptions e) => e.name).join(', ')}',
            style: textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
