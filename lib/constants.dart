import 'package:flutter/material.dart';

List imgList = [
  'images/blue1.png',
  'images/blue2.png',
  'images/blue3.png',
  'images/blue4.png',
  'images/pic1.png',
  'images/pic2.png',
  'images/pic3.png',
  'images/safe_greetings.png',
  'images/handshaking.png',
  'images/wearing_gloves.png'
];

cTitle(color){
  return TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: 'Arvo',
    color: color,
  );
}

var rFont=TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  fontFamily: 'Patrick Hand',
  color: Colors.black,
);

rFontColor(color){
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'Patrick Hand',
    color: color,
  );
}
