import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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
                  }
                },
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(minWidth: 100, minHeight: 32),
                  child: Text(
                    _likesTheApp == null
                        ? localization.yesItsGreat
                        : localization.sureHappyTo,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_likesTheApp == null) {
                    setState(() {
                      _likesTheApp = false;
                    });
                  }
                },
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(minWidth: 100, minHeight: 32),
                  child: Text(
                    _likesTheApp == null
                        ? localization.notSoMuch
                        : localization.noNotNow,
                    textAlign: TextAlign.center,
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
