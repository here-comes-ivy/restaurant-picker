import 'package:flutter/material.dart';

class ResponsiveSize {
  final BuildContext context;

  ResponsiveSize(this.context);

  static Size _getScreenSize(BuildContext context) => MediaQuery.of(context).size;

  static double dialogWidth(BuildContext context) => _getScreenSize(context).width * 0.8;
  static double dialogHeight(BuildContext context) => _getScreenSize(context).height * 0.8;


}

