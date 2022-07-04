import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';

class ReviewApp extends StatefulWidget {
  const ReviewApp({Key key}) : super(key: key);

  @override
  State<ReviewApp> createState() => _ReviewAppState();
}

class _ReviewAppState extends State<ReviewApp> {
  bool _likesTheApp;

  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);

    // TODO remove this code
    if (!isMobileOS()) {
      return SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FormCard(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          Text(
            _likesTheApp == null
                ? localization.areYouEnjoyingTheApp
                : _likesTheApp == true
                    ? localization.wouldYouRateIt
                    : localization.wouldYouTellUsMore,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Wrap(
            children: [
              TextButton(
                onPressed: () async {
                  if (_likesTheApp == null) {
                    setState(() {
                      _likesTheApp = true;
                    });
                  } else {
                    if (_likesTheApp == true) {
                      if (await inAppReview.isAvailable()) {
                        inAppReview.requestReview();
                      } else if (kIsWeb || isLinux()) {
                        launch(getRateAppURL(context));
                      } else {
                        inAppReview.openStoreListing(
                          appStoreId: kAppStoreId,
                          microsoftStoreId: kMicrosoftAppStoreId,
                        );
                      }
                    } else {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) => ContactUsDialog(),
                      );
                    }

                    store.dispatch(DismissReviewAppPermanently());
                  }
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      _likesTheApp == null
                          ? localization.yesItsGreat
                          : localization.sureHappyTo,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (_likesTheApp == null) {
                    setState(() {
                      _likesTheApp = false;
                    });
                  } else {
                    store.dispatch(DismissReviewAppPermanently());
                  }
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      _likesTheApp == null
                          ? localization.notSoMuch
                          : localization.noNotNow,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
