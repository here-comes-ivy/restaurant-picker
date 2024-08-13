import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'spinner.dart';
import '../utils/responsiveSize.dart';

class ModalBottomSheetContent extends StatefulWidget {
  @override
  State<ModalBottomSheetContent> createState() => _ModalBottomSheetContentState();

  static void showCustomModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        return ModalBottomSheetContent();
      },
    );
  }
}

class _ModalBottomSheetContentState extends State<ModalBottomSheetContent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: ResponsiveSize.spinButtonHeight(context),
      width: ResponsiveSize.SpinButtonWidth(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Not sure what to eat?', style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.orange),
            ),
            child: Text(
              'Surprise me!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Spinner()),
                );
            },
          ),
        ],
      ),
    );
  }
}
