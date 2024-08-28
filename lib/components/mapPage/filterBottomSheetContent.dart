import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/cardStyles.dart';
import 'roundIconButton.dart';
import '../../utils/decorationStyles.dart';
import 'radiusSlider.dart';
import 'restaurantTypeFilter.dart';

// Place Type: restaurant, cafe, bar (includedPrimaryTypes??)
// Restaurant category,
// distance: locationRestriction
// priceLevel: priceLevel
// opening hours
// 地點屬性: delivery, dineIn, takeout, reservable, servesBeer, servesBeer

class FilterPageContent extends StatefulWidget {
  const FilterPageContent({Key? key}) : super(key: key);

  @override
  _FilterPageContentState createState() => _FilterPageContentState();
}

class _FilterPageContentState extends State<FilterPageContent> {
  int radius = 3;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        RadiusSlider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Divider(),
        ),
        RestaurantTypeMultipleChoice(),

        // 添加更多篩選器選項...
      ],
    );
  }

  Widget _buildFilterCard(String title, String value) {
    return Card(
      color: Colors.deepOrangeAccent,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundIconButton(
                  icon: Icons.remove,
                  onPressed: () {
                    // 處理減少邏輯
                  },
                ),
                SizedBox(width: 16),
                RoundIconButton(
                  icon: Icons.add,
                  onPressed: () {
                    // 處理增加邏輯
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _RestaurantFilterCardState();
}

class _RestaurantFilterCardState extends State<FilterPage> {
  int radius = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 50.0,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kSearchAddressInputDecoration,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: FilterCard(
            color: Colors.deepOrangeAccent,
            cardChild: Column(
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
                    min: 1.0,
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
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: FilterCard(
                  color: Colors.deepOrangeAccent,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Price Range',
                      ),
                      Text('1000'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {});
                              }),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FilterCard(
                  color: Colors.deepOrangeAccent,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Persons',
                      ),
                      Text('5'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(
                                () {},
                              );
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {});
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
