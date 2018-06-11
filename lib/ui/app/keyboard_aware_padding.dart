import 'package:flutter/material.dart';

class KeyboardAwarePadding extends StatelessWidget {

  KeyboardAwarePadding({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShown = MediaQuery.of(context).viewInsets.bottom > 0;

    return Padding(
        padding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0, bottom: isKeyboardShown ? 0.0 : 12.0),
        child: child
    );
  }
}
