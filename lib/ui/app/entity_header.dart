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
    final textColor = Theme.of(context).primaryTextTheme.bodyText1.color;

    Widget _value1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label,
              style: TextStyle(
                fontSize: 16.0,
                color: textColor.withOpacity(.65),
              )),
          SizedBox(
            height: 8,
          ),
          Text(
            value ?? '',
            style: TextStyle(
              fontSize: 30.0,
              //fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }

    Widget _value2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(secondLabel,
              style: TextStyle(
                fontSize: 16.0,
                color: textColor.withOpacity(.65),
              )),
          SizedBox(
            height: 8,
          ),
          Text(
            secondValue ?? '',
            style: TextStyle(
              fontSize: 30.0,
            ),
          )
        ],
      );
    }

    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 25),
        child: Flex(
          direction: value.length > 12 || (secondValue ?? '').length > 12
              ? Axis.vertical
              : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _value1()),
            if (secondValue != null) Expanded(child: _value2()),
          ],
        ),
      ),
    );
  }
}
