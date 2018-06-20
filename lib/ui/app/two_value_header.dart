import 'package:flutter/material.dart';

class TwoValueHeader extends StatelessWidget {
  TwoValueHeader({this.label1, this.label2, this.value1, this.value2});
  String label1;
  String label2;
  double value1;
  double value2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
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
                      value1?.toStringAsFixed(2) ?? '',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Column(
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
                      value2?.toStringAsFixed(2) ?? '',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            )
            //child: _headerRow(),
            ),
      ),
    );
  }
}
