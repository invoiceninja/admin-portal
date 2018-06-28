import 'package:flutter/material.dart';

class TwoValueHeader extends StatelessWidget {
  TwoValueHeader({this.label1, this.label2, this.value1, this.value2});
  final String label1;
  final String label2;
  final String value1;
  final String value2;

  @override
  Widget build(BuildContext context) {
    _value1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label1,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
              )),
          SizedBox(
            height: 6.0,
          ),
          Text(
            value1 ?? '',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }

    _value2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label2,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
              )),
          SizedBox(
            height: 6.0,
          ),
          Text(
            value2 ?? '',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _value1(),
                  _value2(),
                ],
              )
              //child: _headerRow(),
              ),
        ),
      ),
    );
  }
}
