import 'package:flutter/material.dart';

class IconMessage extends StatelessWidget {

  const IconMessage(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.info_outline,
              size: 18.0,
              color: Colors.white,
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: Text(
                text,
                maxLines: null,
                //keyboardType: TextInputType.multiline,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
