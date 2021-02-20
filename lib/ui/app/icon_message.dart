import 'package:flutter/material.dart';

class IconMessage extends StatelessWidget {
  const IconMessage(this.text, {this.iconData, this.color});
  final String text;
  final IconData iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).primaryColorDark,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: <Widget>[
            Icon(
              iconData ?? Icons.info_outline,
              size: 18.0,
              color: Colors.white,
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: Text(
                text,
                maxLines: null,
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
