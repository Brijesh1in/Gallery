import 'package:flutter/material.dart';

class SizeConfig{

  static double width;
  static double height;
  static double blockHeight;
  static double blockWidth;
  
  static void init(BuildContext context){
    
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    blockHeight = height/100.0;
    blockWidth = width/100.0;
  }
  
}