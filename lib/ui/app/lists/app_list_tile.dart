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
    this.buttons,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool dense;
  final Function onTap;
  final String copyValue;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        leading: Icon(icon),
        title: Text(title),
        subtitle: buttons != null
            ? Row(
                children: buttons,
              )
            : (subtitle == null ? Container() : Text(subtitle)),
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
