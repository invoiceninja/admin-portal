import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';

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

AppLayout calculateLayout(BuildContext context) {
  final size = MediaQuery.of(context).size.shortestSide;
  if (size < kMobileLayoutWidth) {
    return AppLayout.mobile;
  } else if (size > kTabletLayoutWidth) {
    return AppLayout.desktop;
  } else {
    return AppLayout.tablet;
  }
}

AppLayout getLayout(BuildContext context) =>
    StoreProvider.of<AppState>(context).state.uiState.layout ??
    AppLayout.mobile;

bool isMobile(BuildContext context) => getLayout(context) == AppLayout.mobile;

bool isTablet(BuildContext context) => getLayout(context) == AppLayout.tablet;

bool isDesktop(BuildContext context) => getLayout(context) == AppLayout.desktop;

bool isDarkMode(BuildContext context) =>
    StoreProvider.of<AppState>(context).state.uiState.enableDarkMode;

bool isSelfHosted(BuildContext context) =>
    StoreProvider.of<AppState>(context).state.isSelfHosted;

bool isHosted(BuildContext context) =>
    StoreProvider.of<AppState>(context).state.isHosted;

bool isPaidAccount(BuildContext context) {
  final company = StoreProvider.of<AppState>(context).state.selectedCompany;

  return isSelfHosted(context) || company.isProPlan || company.isEnterprisePlan;
}
