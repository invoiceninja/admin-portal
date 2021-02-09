import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog(
    this.message, {
    this.onDismiss,
    this.onDiscard,
    this.dismissLabel,
    this.secondaryActions,
  });

  final String message;
  final String dismissLabel;
  final List<TextButton> secondaryActions;
  final Function onDismiss;
  final Function onDiscard;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Padding(
      padding: EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 24),
      child: Column(
        children: <Widget>[
          Material(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (onDiscard != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextButton(
                              autofocus: true,
                              child: Text(
                                  localization.discardChanges.toUpperCase()),
                              onPressed: () {
                                Navigator.of(context).pop();
                                onDiscard();
                              }),
                        ),
                      if (secondaryActions != null)
                        Row(
                          children: secondaryActions
                              .map((action) => Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: action,
                                  ))
                              .toList(),
                        ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onDismiss != null) {
                            onDismiss();
                          }
                        },
                        child: Text((dismissLabel ?? localization.dismiss)
                            .toUpperCase()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
