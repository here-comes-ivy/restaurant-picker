import 'package:flutter/material.dart';
import 'package:restaurant_picker/temp/spinbutton.dart';

class ResponsiveSize {
  final BuildContext context;

  ResponsiveSize(this.context);

  static Size _getScreenSize(BuildContext context) => MediaQuery.of(context).size;

  static double SpinButtonWidth(BuildContext context) => _getScreenSize(context).width * 0.8;
  static double spinButtonHeight(BuildContext context) => _getScreenSize(context).height * 0.3;

  static double spinDialogWidth(BuildContext context) => _getScreenSize(context).width * 0.6;
  static double spinDialogHeight(BuildContext context) => _getScreenSize(context).height * 0.4;


}

