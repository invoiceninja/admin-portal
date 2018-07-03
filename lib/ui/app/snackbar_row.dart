import 'package:flutter/material.dart';

class SnackBarRow extends StatelessWidget {
  final String message;
  final IconData icon;

  const SnackBarRow({
    this.message,
    this.icon = Icons.check_circle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(message),
        )
      ],
    );
  }
}
