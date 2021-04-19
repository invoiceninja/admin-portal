import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

bool isAndroid(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.android;

String getMapURL(BuildContext context) => isAndroid(context)
    ? 'https://maps.google.com/?q='
    : 'http://maps.apple.com/?address=';

String getLegacyAppURL(BuildContext context) => isAndroid(context)
    ? 'https://play.google.com/store/apps/details?id=com.invoiceninja.invoiceninja'
    : 'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1220337560&mt=8';

String getPdfRequirements(BuildContext context) {
  final localization = AppLocalization.of(context);
  if (isMobile(context)) {
    final version = isAndroid(context) ? 'Android 5.0+' : 'iOS 11.0+';
    return localization.pdfMinRequirements.replaceFirst(':version', version);
  } else {
    return '';
  }
}

String getPlatform(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.iOS ? 'ios' : 'android';

String getAppURL(BuildContext context) {
  switch (Theme.of(context).platform) {
    case TargetPlatform.android:
      return kGoogleStoreUrl;
    case TargetPlatform.iOS:
      return kAppleStoreUrl;
    default:
      return kCapterralUrl;
  }
}

AppLayout calculateLayout(BuildContext context) {
  final size = MediaQuery.of(context).size.width;

  if (size < kMobileLayoutWidth) {
    return AppLayout.mobile;
  } else {
    return AppLayout.desktop;
  }
}

AppLayout getLayout(BuildContext context) =>
    StoreProvider.of<AppState>(context).state.prefState.appLayout ??
    AppLayout.mobile;

bool isMobile(BuildContext context) => getLayout(context) == AppLayout.mobile;

bool isNotMobile(BuildContext context) => !isMobile(context);

bool isDesktop(BuildContext context) => getLayout(context) == AppLayout.desktop;

bool isNotDesktop(BuildContext context) => !isDesktop(context);

bool isDarkMode(BuildContext context) =>
    StoreProvider.of<AppState>(context).state.prefState.enableDarkMode;

bool isSelfHosted(BuildContext context) =>
    StoreProvider.of<AppState>(context).state.isSelfHosted;

bool isHosted(BuildContext context) =>
    StoreProvider.of<AppState>(context).state.isHosted;

bool isPaidAccount(BuildContext context) =>
    StoreProvider.of<AppState>(context).state.isPaidAccount;
