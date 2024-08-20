import 'package:flutter/material.dart';
import '../utils/colorSetting.dart';


const kTextInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  //icon: Icon(Icons.near_me),
  hintText: 'Search Location',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: 
    BorderRadius.all(
      Radius.circular(10.0),),
    borderSide: BorderSide.none,
  ),
);


var kProfileTitleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
  );


const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: appColors.primary, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: appColors.primary, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);