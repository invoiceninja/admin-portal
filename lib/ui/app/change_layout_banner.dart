// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ChangeLayoutBanner extends StatefulWidget {
  const ChangeLayoutBanner({
    Key? key,
    required this.child,
    required this.appLayout,
    required this.suggestedLayout,
  }) : super(key: key);

  final Widget child;
  final AppLayout appLayout;
  final AppLayout suggestedLayout;

  @override
  _ChangeLayoutBannerState createState() => _ChangeLayoutBannerState();
}

class _ChangeLayoutBannerState extends State<ChangeLayoutBanner> {
  bool _dismissedChange = false;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context)!;

    final calculatedLayout = calculateLayout(context);
    String? message;

    if (!_dismissedChange) {
      if (widget.appLayout == AppLayout.mobile &&
          widget.suggestedLayout == AppLayout.mobile &&
          calculatedLayout == AppLayout.desktop) {
        message = localization.changeToDekstopLayout;
      } else if (widget.appLayout == AppLayout.desktop &&
          widget.suggestedLayout == AppLayout.desktop &&
          calculatedLayout == AppLayout.mobile) {
        message = localization.changeToMobileLayout;
      }
    }

    return SafeArea(
      top: message != null,
      bottom: message != null,
      child: Column(
        children: [
          AnimatedContainer(
            height: message == null ? 0 : kTopBottomBarHeight,
            duration: Duration(milliseconds: kDefaultAnimationDuration),
            curve: Curves.easeInOutCubic,
            child: Material(
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: IconText(
                        style: TextStyle(color: Colors.white),
                        icon: Icons.info_outline,
                        text: message,
                      ),
                    ),
                    AppTextButton(
                      label: localization.dismiss,
                      color: Colors.white,
                      onPressed: () {
                        setState(() => _dismissedChange = true);
                      },
                    ),
                    AppTextButton(
                      label: localization.change,
                      color: Colors.white,
                      onPressed: () {
                        final layout =
                            widget.suggestedLayout == AppLayout.desktop
                                ? AppLayout.mobile
                                : AppLayout.desktop;
                        store
                            .dispatch(UpdateUserPreferences(appLayout: layout));
                        AppBuilder.of(context)!.rebuild();
                        WidgetsBinding.instance
                            .addPostFrameCallback((duration) {
                          if (layout == AppLayout.mobile) {
                            store.dispatch(ViewDashboard());
                          } else {
                            store.dispatch(ViewMainScreen(addDelay: true));
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: widget.child,
          )
        ],
      ),
    );
  }
}
