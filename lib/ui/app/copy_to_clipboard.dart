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
  }) : super(key: key);

  final Widget child;
  final String value;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    if ((value ?? '').isEmpty) {
      return child;
    }

    final widget = child == null ? Text(value) : child;
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
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: widget,
        ),
      );
    } else {
      return InkWell(
        child: widget,
        onTap: onTap,
      );
    }
  }
}
