import 'package:flutter/material.dart';
import '../../util/Config.dart';

class TextBlock extends StatelessWidget {
  TextBlock({@required this.text });

  final String text;
  double textSize = 28;
  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
          backgroundColor: Config.secondaryColor,
          color: Colors.white,
          fontSize: textSize),
    );
  }
}
