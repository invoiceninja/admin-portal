import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({this.text, this.icon, this.style});
  final String text;
  final IconData icon;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: 8),
        Text(text, style: style),
      ],
    );
  }
}
