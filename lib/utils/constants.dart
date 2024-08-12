import 'package:flutter/material.dart';


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