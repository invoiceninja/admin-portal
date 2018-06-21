import 'package:flutter/material.dart';

class IconMessage extends StatelessWidget {

  IconMessage(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.info_outline,
                size: 18.0,
                color: Colors.grey[800],
              ),
              SizedBox(width: 10.0),
              Flexible(
                child: Text(
                  text,
                  maxLines: null,
                  //keyboardType: TextInputType.multiline,
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
