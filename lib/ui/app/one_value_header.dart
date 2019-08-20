import 'package:flutter/material.dart';

class OneValueHeader extends StatelessWidget {
  const OneValueHeader({
    this.backgroundColor,
    this.label,
    this.value,
  });

  final MaterialColor backgroundColor;
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.3, 0.5, 0.9],
          colors: [
            (backgroundColor ?? Colors.grey)[300],
            (backgroundColor ?? Colors.grey)[400],
            (backgroundColor ?? Colors.grey)[500],
            (backgroundColor ?? Colors.grey)[600],
          ],
        ),
      ),
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
