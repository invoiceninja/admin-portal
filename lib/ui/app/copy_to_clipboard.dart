import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CopyToClipboard extends StatelessWidget {
  const CopyToClipboard({
    Key? key,
    required this.value,
    this.child,
    this.showBorder = false,
    this.onLongPress,
    this.prefix,
  }) : super(key: key);

  final Widget? child;
  final String? value;
  final bool showBorder;
  final Function? onLongPress;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    if ((value ?? '').isEmpty) {
      return SizedBox();
    }

    final widget = child == null
        ? Text(
            prefix != null ? '$prefix: $value' : value!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        : child;
    final localization = AppLocalization.of(context);
    final onTap = value == null
        ? null
        : () {
            Clipboard.setData(ClipboardData(text: value!));

            var valueStr = value!.replaceAll('\n', ' ');
            if (value!.length > 20) {
              valueStr = value!.substring(0, 20) + '...';
            }

            showToast(
              localization!.copiedToClipboard.replaceFirst(
                ':value',
                '"$valueStr"',
              ),
            );
          };

    if (showBorder) {
      return ConstrainedBox(
        child: OutlinedButton(
          onPressed: onTap,
          child: widget,
          onLongPress: onLongPress as void Function()?,
        ),
        constraints: BoxConstraints(maxWidth: 180),
      );
    } else {
      return InkWell(
        child: widget,
        onTap: onTap,
        onLongPress: onLongPress as void Function()?,
      );
    }
  }
}
