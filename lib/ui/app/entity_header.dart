import 'package:flutter/material.dart';

class EntityHeader extends StatelessWidget {
  const EntityHeader({
    @required this.label,
    @required this.value,
    this.secondLabel,
    this.secondValue,
    this.backgroundColor,
  });

  final Color backgroundColor;
  final String label;
  final String value;
  final String secondLabel;
  final String secondValue;

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

    Widget _value2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(secondLabel,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
              )),
          SizedBox(
            height: 6.0,
          ),
          Text(
            secondValue ?? '',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }

    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Flex(
                direction: value.length > 12 || (secondValue ?? '').length > 12
                    ? Axis.vertical
                    : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _value1(),
                  if (secondValue != null) _value2(),
                ],
              )
              //child: _headerRow(),
              ),
        ),
      ),
    );
  }
}
