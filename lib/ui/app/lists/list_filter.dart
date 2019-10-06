import 'package:flutter/material.dart';

class ListFilterMessage extends StatelessWidget {
  const ListFilterMessage({
    @required this.title,
    @required this.onPressed,
    @required this.onClearPressed,
  });

  final String title;
  final Function(BuildContext) onPressed;
  final Function() onClearPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orangeAccent,
      elevation: 6.0,
      child: InkWell(
        onTap: () => onPressed(context),
        child: Row(
          children: <Widget>[
            SizedBox(width: 18.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () => onClearPressed(),
            )
          ],
        ),
      ),
    );
  }
}
