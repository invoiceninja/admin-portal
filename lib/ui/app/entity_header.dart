import 'package:flutter/material.dart';

class EntityHeader extends StatelessWidget {
  const EntityHeader({
    @required this.label,
    @required this.value,
    this.secondLabel,
    this.secondValue,
    this.backgroundColor,
  });

  final MaterialColor backgroundColor;
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
