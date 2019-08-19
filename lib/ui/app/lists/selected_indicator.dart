import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class SelectedIndicator extends StatelessWidget {
  const SelectedIndicator({this.child, this.isSelected});

  final Widget child;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: null,
      child: Row(
        children: <Widget>[
          Container(
            width: 3,
            height: 48,
            color: isSelected && !isMobile(context)
                ? Theme.of(context).accentColor
                : null,
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
