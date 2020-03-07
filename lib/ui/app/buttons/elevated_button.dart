import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';

class ElevatedButton extends StatelessWidget {
  const ElevatedButton(
      {@required this.label,
      @required this.onPressed,
      this.iconData,
      this.color,
      this.width});

  final Color color;
  final IconData iconData;
  final String label;
  final Function onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: color ?? Theme.of(context).buttonColor,
        child: iconData != null
            ? IconText(
                icon: iconData,
                text: label,
              )
            : Text(label),
        textColor: Colors.white,
        elevation: 4.0,
        onPressed: () => onPressed(),
      ),
    );
  }
}
