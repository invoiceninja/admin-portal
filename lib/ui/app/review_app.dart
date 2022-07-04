import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewApp extends StatefulWidget {
  const ReviewApp({Key key}) : super(key: key);

  @override
  State<ReviewApp> createState() => _ReviewAppState();
}

class _ReviewAppState extends State<ReviewApp> {
  bool _likesTheApp;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FormCard(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _likesTheApp == null
                ? localization.areYouEnjoyingTheApp
                : _likesTheApp == true
                    ? localization.wouldYouLeaveAReview
                    : localization.wouldYouTellUsMore,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Wrap(
            children: [
              TextButton(
                onPressed: () {
                  if (_likesTheApp == null) {
                    setState(() {
                      _likesTheApp = true;
                    });
                  } else {
                    if (_likesTheApp == true) {
                      launch(getRateAppURL(context));
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
