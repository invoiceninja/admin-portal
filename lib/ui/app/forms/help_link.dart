// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/localization.dart';

class HelpLink extends StatelessWidget {
  const HelpLink({
    required this.url,
    required this.message,
  });

  final String url;
  final String message;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final ThemeData themeData = Theme.of(context);
    final TextStyle? aboutTextStyle = themeData.textTheme.bodyMedium;
    final TextStyle linkStyle = themeData.textTheme.bodyMedium!
        .copyWith(color: themeData.colorScheme.secondary);

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl(Uri.parse(url));
                },
              text: localization.clickHereCapital + ' ',
            ),
            TextSpan(
              style: aboutTextStyle,
              text: message,
            ),
          ],
        ),
      ),
    );
  }
}
