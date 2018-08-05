import 'package:flutter/material.dart';

class IconText extends StatelessWidget {

  const IconText({this.text, this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: 6.0),
        Text(text),
      ],
    );
  }
}
