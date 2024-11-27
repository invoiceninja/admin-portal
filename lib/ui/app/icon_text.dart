// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';

class IconText extends StatelessWidget {
  const IconText({
    this.text,
    this.icon,
    this.style,
    this.alignment,
    this.copyToClipboard = false,
    this.iconSize,
    this.maxLines,
  });

  final String? text;
  final IconData? icon;
  final TextStyle? style;
  final MainAxisAlignment? alignment;
  final bool copyToClipboard;
  final double? iconSize;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment ?? MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
          color: style?.color,
          size: iconSize,
        ),
        SizedBox(width: 10),
        Flexible(
          child: copyToClipboard
              ? CopyToClipboard(
                  value: text,
                  child: Text(
                    text ?? '',
                    style: style,
                    overflow: TextOverflow.ellipsis,
                    maxLines: maxLines,
                  ))
              : Text(
                  text ?? '',
                  style: style,
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLines,
                ),
        ),
      ],
    );
  }
}
