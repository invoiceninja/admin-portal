import 'package:flutter/material.dart';

class OneValueHeader extends StatelessWidget {
  const OneValueHeader({
    this.backgroundColor,
    this.label,
    this.value,
  });

  final Color backgroundColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    Widget _value1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
              )),
          SizedBox(
            height: 6.0,
          ),
          Text(
            value ?? '',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }

    return Container(
      color: backgroundColor ?? Theme.of(context).backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: _value1(),
          ),
        ),
      ),
    );
  }
}
