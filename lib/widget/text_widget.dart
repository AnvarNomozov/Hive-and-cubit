import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  String text;
  double size;
  Color? color = Colors.black;
  TextWidget({
    required this.text,
    required this.size,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}
