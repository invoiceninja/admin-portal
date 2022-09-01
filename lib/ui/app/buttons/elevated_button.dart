// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    @required this.label,
    @required this.onPressed,
    this.iconData,
    this.color,
    this.width,
  });

  final Color color;
  final IconData iconData;
  final String label;
  final Function onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: color ?? Theme.of(context).colorScheme.secondary,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius)),
        elevation: 4,
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: iconData != null
          ? IconText(
              icon: iconData,
              text: label,
              alignment: MainAxisAlignment.center,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          : SizedBox(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              height: 24,
            ),
      onPressed: onPressed,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: width == null
          ? button
          : SizedBox(
              width: width,
              child: button,
            ),
    );
  }
}
