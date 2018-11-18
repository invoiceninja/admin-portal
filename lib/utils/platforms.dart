import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';

bool isAndroid(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.android;

String getMapURL(BuildContext context) => isAndroid(context)
    ? 'https://maps.google.com/?q='
    : 'http://maps.apple.com/?address=';

String getLegacyAppURL(BuildContext context) => isAndroid(context)
    ? 'https://play.google.com/store/apps/details?id=com.invoiceninja.invoiceninja'
    : 'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1220337560&mt=8';

String getPlatform(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.iOS ? 'ios' : 'android';

String getAppURL(BuildContext context) =>
    isAndroid(context) ? kGoogleStoreUrl : kAppleStoreUrl;
