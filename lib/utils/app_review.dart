import 'package:in_app_review/in_app_review.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class AppReview {
  // False in the FOSS build, which on Android is the one on F-Droid
  static const bool isStoreBuild = true;

  static final InAppReview inAppReview = InAppReview.instance;

  static Future<bool> isAvailable() async => await inAppReview.isAvailable();

  static void requestReview() => inAppReview.requestReview();

  static void openStoreListing() => inAppReview.openStoreListing(
    appStoreId: isAndroid() ? kPlayStoreAppId : kAppStoreAppId,
    microsoftStoreId: kMicrosoftAppStoreId,
  );
}
