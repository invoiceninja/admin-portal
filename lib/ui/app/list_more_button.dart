import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ListMoreButton extends StatelessWidget {
  const ListMoreButton({@required this.onPressed});

  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Tooltip(
        message: localization.more,
        child: PopupMenuButton<String>(
          onSelected: onPressed,
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'select',
              child: Text(localization.select),
            ),
          ],
        ));
  }
}
