import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget {

  static final String route = '/';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          SizedBox(
            height: 4.0,
            child: LinearProgressIndicator(),
          )
        ],
      ),
    );
  }
}
