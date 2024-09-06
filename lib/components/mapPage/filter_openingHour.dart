import 'package:flutter/material.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';

List<int> convertDaysToNumbers(List<String> days) {
  final Map<String, int> dayToNumber = {
    'S': 0, // Sunday
    'M': 1, // Monday
    'T': 2, // Tuesday
    'W': 3, // Wednesday
    'T': 4, // Thursday
    'F': 5, // Friday
    'S': 6, // Saturday
  };

  return days.map((day) => dayToNumber[day] ?? -1).toList();
}

class OpeningHourFilter extends StatefulWidget {
  const OpeningHourFilter({Key? key}) : super(key: key);

  @override
  State<OpeningHourFilter> createState() => _OpeningHourFilterState();
}

class _OpeningHourFilterState extends State<OpeningHourFilter> {
  int? _index = 1;

  int selectedHour = DateTime.now().hour;
  int selectedMinute = 0; // Changed this line

  final Set<int> _selectedDays = {DateTime.now().weekday % 7};
  final List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  late final List<int> convertedDays;

  @override
  void initState() {
    super.initState();
    convertedDays = convertDaysToNumbers(days);
    // Round the current minute to the nearest 15-minute interval
    int currentMinute = DateTime.now().minute;
    selectedMinute = (currentMinute ~/ 15) * 15;
  }

  @override
  Widget build(BuildContext context) {
    return FilterCard(
      title: 'Opening Hour',
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0),
          Wrap(
            spacing: 5.0,
            children: [
              ChoiceChip(
                label: Text('Anytime'),
                selected: _index == 1,
                onSelected: (bool selected) {
                  setState(() {
                    _index = selected ? 1 : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('Opening Now'),
                selected: _index == 2,
                onSelected: (bool selected) {
                  setState(() {
                    _index = selected ? 2 : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('Customize'),
                selected: _index == 3,
                onSelected: (bool selected) {
                  setState(() {
                    _index = selected ? 3 : null;
                  });
                },
              ),
            ],
          ),
          if (_index == 3) ...[
            SizedBox(height: 10),
            Column(
              children: [
                Wrap(
                  children: List<Widget>.generate(
                    7,
                    (int index) {
                      String text = days[index];
                      return FilterChip(
                        showCheckmark: false,
                        shape: CircleBorder(),
                        label: Text(text),
                        selected: _selectedDays.contains(convertedDays[index]),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              _selectedDays.add(convertedDays[index]);
                            } else {
                              _selectedDays.remove(convertedDays[index]);
                            }
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: selectedHour,
                      hint: Text('Select hour'),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedHour = newValue!;
                        });
                      },
                      items: List<int>.generate(24, (i) => i)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value:00'),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 20),
                    DropdownButton<int>(
                      value: selectedMinute,
                      hint: Text('Select minute'),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedMinute = newValue!;
                        });
                      },
                      items: [0, 15, 30, 45]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
