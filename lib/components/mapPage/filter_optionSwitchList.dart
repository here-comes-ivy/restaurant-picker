import 'package:flutter/material.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';


class OptionSwitchList extends StatefulWidget {
  const OptionSwitchList({super.key});

  @override
  State<OptionSwitchList> createState() => _OptionSwitchListState();
}

class _OptionSwitchListState extends State<OptionSwitchList> {

  //places.delivery,places.allowsDogs,places.servesVegetarianFood,places.reservable,places.goodForGroups

  bool deliverySwitch = false;
  bool reservable = false;
  bool vegetarianSwitch = false;
  bool allowPetSwich = false;
  bool goodForGroupsSwitch = false;

  @override
  Widget build(BuildContext context) {
    return FilterCard(
      title: 'More options',
      cardChild: Column(
          children: <Widget>[
            SwitchListTile(
              value: deliverySwitch,
              onChanged: (bool? value) {
                setState(() {
                  deliverySwitch = value!;
                });
              },
              title: Text('Delivery Available'),
            ),
            Divider(height: 0),
            
            SwitchListTile(
              value: reservable,
              onChanged: (bool? value) {
                setState(() {
                  reservable = value!;
                });
              },
              title: Text('Reservations available'),
             
            ),
            Divider(height: 0),
            SwitchListTile(
              value: vegetarianSwitch,
              onChanged: (bool? value) {
                setState(() {
                  vegetarianSwitch = value!;
                });
              },
              title: Text('Vegetarian options available'),
            ),
            Divider(height: 0),
            SwitchListTile(
              value: goodForGroupsSwitch,
              onChanged: (bool? value) {
                setState(() {
                  goodForGroupsSwitch = value!;
                });
              },
              title: Text('Good for Groups'),
            ),
            Divider(height: 0),
            SwitchListTile(
              value: allowPetSwich,
              onChanged: (bool? value) {
                setState(() {
                  allowPetSwich = value!;
                });
              },
              title: Text('Pets allowed'),
            ),
            Divider(height: 0),
          ],
        
      ),
    );
  }
}
