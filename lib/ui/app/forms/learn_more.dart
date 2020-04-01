import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnMore extends StatelessWidget {
  const LearnMore({
    @required this.child,
    @required this.url,
  });

  final Widget child;
  final String url;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    if (url.isEmpty) {
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
        FlatButton(
          child: Text(localization.learnMore),
          onPressed: () async {
            if (await canLaunch(url)) {
              await launch(url, forceSafariVC: false, forceWebView: false);
            }
          },
        ),
      ],
    );
  }
}
