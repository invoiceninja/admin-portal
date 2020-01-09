import 'package:flutter/material.dart';

class HelpText extends StatelessWidget {
  const HelpText(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Opacity(
          opacity: 0.5,
          child: Text(
            message,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
