import 'package:flutter/material.dart';

class SelectedIndicator extends StatelessWidget {
  const SelectedIndicator({this.child, this.isSelected});

  final Widget child;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 1.5,
          height: 48,
          color:
              isSelected ? Theme.of(context).accentColor : Colors.transparent,
        ),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
