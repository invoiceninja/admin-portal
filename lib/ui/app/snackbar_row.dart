import 'package:flutter/material.dart';

class SnackBarRow extends StatelessWidget {
  const SnackBarRow({
    this.message,
    this.icon = Icons.check_circle,
  });

  final String message;
  final IconData icon;

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
