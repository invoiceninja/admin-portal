import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CopyToClipboard extends StatelessWidget {
  const CopyToClipboard({
    Key key,
    this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return InkWell(
      child: Text(value),
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
