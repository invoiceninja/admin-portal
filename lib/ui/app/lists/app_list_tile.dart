import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    this.icon,
    this.title,
    this.subtitle,
    this.dense = false,
    this.onTap,
    this.copyValue,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool dense;
  final Function onTap;
  final String copyValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).canvasColor,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
        leading: Icon(icon),
        title: Text(title),
        subtitle: subtitle == null ? Container() : Text(subtitle),
        dense: dense,
        onTap: onTap,
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: copyValue ?? title));
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalization.of(context)
                  .copiedToClipboard
                  .replaceFirst(':value', copyValue ?? title))));
        },
      ),
    );
  }
}
