import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'spinner_spinnerBuilder.dart';
import 'package:restaurant_picker/utils/smallWidgetBuilder.dart';

class SpinnerBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHandler(),
            SpinnerBuilder(),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: true, 
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SpinnerBottomSheet(),
    );
  }
}