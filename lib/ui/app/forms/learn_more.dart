// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/localization.dart';

class LearnMoreUrl extends StatelessWidget {
  const LearnMoreUrl({
    required this.child,
    required this.url,
    this.label,
  });

  final Widget child;
  final String url;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    if ((url).isEmpty) {
      return child;
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: child,
        ),
        SizedBox(
          width: 10,
        ),
        TextButton(
          child: Text(label ?? localization!.learnMore),
          onPressed: () => launchUrl(Uri.parse(url)),
        ),
      ],
    );
  }
}

class LearnMoreDialog extends StatelessWidget {
  const LearnMoreDialog({
    required this.child,
    required this.dialog,
    this.label,
  });

  final Widget child;
  final Widget dialog;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: child,
        ),
        SizedBox(
          width: 10,
        ),
        TextButton(
          child: Text(label ?? localization!.learnMore),
          onPressed: () {
            showDialog<AlertDialog>(
                context: context,
                builder: (BuildContext context) {
                  return dialog;
                });
          },
        ),
      ],
    );
  }
}
