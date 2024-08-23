import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rubber/rubber.dart';
import 'map_spinner.dart';
import '../utils/responsiveSize.dart';

class ModalBottomSheetContent extends StatefulWidget {
  @override
  State<ModalBottomSheetContent> createState() => _ModalBottomSheetContentState();

  static void showCustomModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
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
      //height: ResponsiveSize.spinButtonHeight(context),
      //width: ResponsiveSize.SpinButtonWidth(context),
      child: Spinner(),
    );
  }
}

