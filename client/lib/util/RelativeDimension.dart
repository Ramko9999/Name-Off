import "package:flutter/material.dart";

class RelativeDimension{

  static double getHeight(BuildContext context, double scale){
    Size deviceSize = MediaQuery.of(context).size;
    double height = deviceSize.height;
    return height * scale;
  }

  static double getWidth(BuildContext context, double scale){
    Size deviceSize = MediaQuery.of(context).size;
    double width = deviceSize.width;
    return width * scale;
  }
}


