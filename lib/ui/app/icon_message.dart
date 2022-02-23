// Flutter imports:
import 'package:flutter/material.dart';

class IconMessage extends StatelessWidget {
  const IconMessage(
    this.text, {
    this.iconData,
    this.color,
    this.trailing,
  });

  final String text;
  final IconData iconData;
  final Color color;
  final Widget trailing;

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
            SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                maxLines: null,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: 16),
              trailing,
            ]
          ],
        ),
      ),
    );
  }
}
