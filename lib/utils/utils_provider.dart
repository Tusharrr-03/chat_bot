import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors{
  static const Color bgColor = Color(0xff101010);
  static const Color secondaryColor = Color(0xff202023);
  static const Color mainColor = Color(0xff2A2A2C);
}

TextStyle mTextStyle16({Color mColor = Colors.black, FontWeight mFontWeight = FontWeight.normal}){
  return TextStyle(
    fontSize: 16,
    fontFamily: 'mainFont',
    color: mColor,
    fontWeight: mFontWeight,
  );
}

TextStyle mTextStyle22({Color mColor = Colors.black, FontWeight mFontWeight = FontWeight.normal}){
  return TextStyle(
    fontSize: 22,
    fontFamily: 'mainFont',
    fontWeight: mFontWeight,
    color: mColor,
  );
}

TextStyle mTextStyle25({Color mColor = Colors.black, FontWeight mFontWeigth = FontWeight.normal}){
  return TextStyle(
    fontSize: 25,
    fontFamily: 'mainFont',
    fontWeight: mFontWeigth,
    color: mColor,
  );
}

TextStyle mTextStyle12({Color mColor = Colors.black, FontWeight mFontWeight = FontWeight.normal}){
  return TextStyle(
    fontSize: 12,
    fontFamily: 'mainFont',
    color: mColor,
    fontWeight: mFontWeight,
  );
}