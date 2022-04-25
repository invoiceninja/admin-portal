import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CopyToClipboard extends StatelessWidget {
  const CopyToClipboard({
    Key key,
    @required this.value,
    this.child,
    this.showBorder = false,
    this.onLongPress,
  }) : super(key: key);

  final Widget child;
  final String value;
  final bool showBorder;
  final Function onLongPress;

  @override
  Widget build(BuildContext context) {
    if ((value ?? '').isEmpty) {
      return SizedBox();
    }

    final widget = child == null
        ? Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        : child;
    final localization = AppLocalization.of(context);
    final onTap = () {
      Clipboard.setData(ClipboardData(text: value));
      showToast(
        localization.copiedToClipboard.replaceFirst(
          ':value',
          value.replaceAll('\n', ' '),
        ),
      );
    };

    if (showBorder) {
      return ConstrainedBox(
        child: OutlinedButton(
          onPressed: onTap,
          child: widget,
          onLongPress: onLongPress,
        ),
        constraints: BoxConstraints(maxWidth: 180),
      );
    } else {
      return InkWell(
        child: widget,
        onTap: onTap,
        onLongPress: onLongPress,
      );
    }
  }
}
