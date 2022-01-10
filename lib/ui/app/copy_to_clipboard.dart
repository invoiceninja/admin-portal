import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CopyToClipboard extends StatelessWidget {
  const CopyToClipboard({
    Key key,
    @required this.child,
    @required this.value,
  }) : super(key: key);

  final Widget child;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return child;
    }

    final localization = AppLocalization.of(context);

    return InkWell(
      child: child,
      onTap: () {
        Clipboard.setData(ClipboardData(text: value));
        showToast(
          localization.copiedToClipboard.replaceFirst(
            ':value',
            value.replaceAll('\n', ' '),
          ),
        );
      },
    );
  }
}
