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
    this.isVertical = false,
  });

  final Widget child;
  final String url;
  final String? label;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    if (url.isEmpty) {
      return child;
    }

    if (isVertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          SizedBox(height: 8),
          OutlinedButton(
            child: Text(
              label ?? localization!.learnMore,
              maxLines: 4,
            ),
            onPressed: () => launchUrl(Uri.parse(url)),
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: child,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextButton(
              child: Text(
                label ?? localization!.learnMore,
                maxLines: 4,
              ),
              onPressed: () => launchUrl(Uri.parse(url)),
            ),
          ),
        ],
      );
    }
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
