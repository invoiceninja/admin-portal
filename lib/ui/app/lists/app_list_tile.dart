// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/localization.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    this.icon,
    this.title,
    this.subtitle,
    this.dense = false,
    this.onLongPress,
    this.copyValue,
    this.buttonRow,
    this.trailing,
  });

  final IconData? icon;
  final String? title;
  final String? subtitle;
  final bool dense;
  final Function? onLongPress;
  final String? copyValue;
  final Widget? buttonRow;
  final Widget? trailing;

  void _onTap(BuildContext context) {
    if ((copyValue ?? title ?? '').isEmpty) {
      return;
    }

    Clipboard.setData(ClipboardData(text: copyValue ?? title ?? ''));
    showToast(AppLocalization.of(context)!
        .copiedToClipboard
        .replaceFirst(':value', copyValue ?? title!));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        leading: Icon(icon),
        title: Text(title!),
        trailing: trailing,
        subtitle: buttonRow != null || subtitle != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null) Text(subtitle!),
                  if (buttonRow != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: buttonRow,
                    )
                ],
              )
            : null,
        dense: dense,
        onTap: () => _onTap(context),
        onLongPress: onLongPress as void Function()?,
      ),
    );
  }
}
