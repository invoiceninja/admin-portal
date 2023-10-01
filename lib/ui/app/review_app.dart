import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewApp extends StatefulWidget {
  const ReviewApp({Key? key}) : super(key: key);

  @override
  State<ReviewApp> createState() => _ReviewAppState();
}

class _ReviewAppState extends State<ReviewApp> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    if (kIsWeb || isLinux()) {
      return SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FormCard(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          Text(
            localization!.wouldYouRateTheApp,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Wrap(
            children: [
              TextButton(
                onPressed: () async {
                  // TODO remove this code: https://github.com/britannio/in_app_review/issues/56
                  if (kIsWeb || isLinux()) {
                    launchUrl(Uri.parse(getRateAppURL(context)));
                  } else if (isAndroid()) {
                    AppReview.openStoreListing();
                  } else if (await AppReview.isAvailable()) {
                    AppReview.requestReview();
                  } else {
                    AppReview.openStoreListing();
                  }

                  if (state.showTwoYearReviewApp) {
                    store.dispatch(DismissTwoYearReviewAppPermanently());
                  } else if (state.showOneYearReviewApp) {
                    store.dispatch(DismissOneYearReviewAppPermanently());
                  } else if (state.showReviewApp) {
                    store.dispatch(DismissReviewAppPermanently());
                  }
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      localization.sureHappyTo,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (state.showTwoYearReviewApp) {
                    store.dispatch(DismissTwoYearReviewAppPermanently());
                  } else if (state.showOneYearReviewApp) {
                    store.dispatch(DismissOneYearReviewAppPermanently());
                  } else if (state.showReviewApp) {
                    store.dispatch(DismissReviewAppPermanently());
                  }
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      localization.noNotNow,
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
