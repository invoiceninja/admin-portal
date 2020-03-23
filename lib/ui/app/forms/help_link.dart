import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpLink extends StatelessWidget {
  const HelpLink({
    @required this.url,
    @required this.message,
  });

  final String url;
  final String message;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.bodyText2;
    final TextStyle linkStyle =
        themeData.textTheme.bodyText2.copyWith(color: themeData.accentColor);

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launch(url, forceSafariVC: false);
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
