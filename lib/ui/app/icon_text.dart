// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';

class IconText extends StatelessWidget {
  const IconText({
    this.text,
    this.icon,
    this.style,
    this.alignment,
  });

  final String text;
  final IconData icon;
  final TextStyle style;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return CopyToClipboard(
      value: text,
      child: Row(
        mainAxisAlignment: alignment ?? MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: style?.color),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              text ?? '',
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
