// Flutter imports:
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/account_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class ImportantMessageBanner extends StatefulWidget {
  const ImportantMessageBanner({
    Key? key,
    required this.child,
    required this.appLayout,
    required this.suggestedLayout,
  }) : super(key: key);

  final Widget child;
  final AppLayout appLayout;
  final AppLayout suggestedLayout;

  @override
  _ImportantMessageBannerState createState() => _ImportantMessageBannerState();
}

class _ImportantMessageBannerState extends State<ImportantMessageBanner> {
  static const MESSAGE_TYPE_LAYOUT = 'layout';
  static const MESSAGE_TYPE_FLUTTER_WEB = 'flutter_web';

  final Map<String, bool> _dismissedMessage = {};

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context)!;

    final calculatedLayout = calculateLayout(context);
    String? message;
    String? messageType;

    if (!_dismissedMessage.containsKey(MESSAGE_TYPE_FLUTTER_WEB) &&
        !state.isDemo) {
      if (kIsWeb || !kReleaseMode) {
        message = localization.flutterWebWarning;
        messageType = MESSAGE_TYPE_FLUTTER_WEB;
      }
    }

    if (message == null &&
        !_dismissedMessage.containsKey(MESSAGE_TYPE_LAYOUT)) {
      if (widget.appLayout == AppLayout.mobile &&
          widget.suggestedLayout == AppLayout.mobile &&
          calculatedLayout == AppLayout.desktop) {
        message = localization.changeToDekstopLayout;
        messageType = MESSAGE_TYPE_LAYOUT;
      } else if (widget.appLayout == AppLayout.desktop &&
          widget.suggestedLayout == AppLayout.desktop &&
          calculatedLayout == AppLayout.mobile) {
        message = localization.changeToMobileLayout;
        messageType = MESSAGE_TYPE_LAYOUT;
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
                    if (messageType == MESSAGE_TYPE_FLUTTER_WEB) ...[
                      AppTextButton(
                        label: localization.webApp,
                        onPressed: () {
                          setState(
                              () => _dismissedMessage[messageType!] = true);
                          if (state.isHosted) {
                            launchUrl(Uri.parse(kAppReactUrl));
                          } else {
                            confirmCallback(
                                context: context,
                                message: localization.enableReactApp,
                                callback: (_) {
                                  final credentials = state.credentials;
                                  final account = state.account.rebuild(
                                      (b) => b..setReactAsDefaultAP = true);
                                  final url =
                                      '${credentials.url}/accounts/${account.id}';
                                  final data = serializers.serializeWith(
                                      AccountEntity.serializer, account);

                                  store.dispatch(StartSaving());
                                  WebClient()
                                      .put(
                                    url,
                                    credentials.token,
                                    data: json.encode(data),
                                  )
                                      .then((dynamic _) {
                                    store.dispatch(StopSaving());
                                    WebUtils.reloadBrowser();
                                  }).catchError((Object error) {
                                    store.dispatch(StopSaving());
                                    showErrorDialog(message: error as String?);
                                  });
                                });
                          }
                        },
                      ),
                      AppTextButton(
                        label: localization.desktopApp,
                        onPressed: () {
                          final platform = getNativePlatform();
                          final url = getNativeAppUrl(platform);

                          if (url.isNotEmpty) {
                            launchUrl(Uri.parse(url));
                          }
                        },
                      ),
                    ] else if (messageType == MESSAGE_TYPE_LAYOUT)
                      AppTextButton(
                        label: localization.change,
                        color: Colors.white,
                        onPressed: () {
                          final layout =
                              widget.suggestedLayout == AppLayout.desktop
                                  ? AppLayout.mobile
                                  : AppLayout.desktop;
                          store.dispatch(
                              UpdateUserPreferences(appLayout: layout));
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
                    AppTextButton(
                      label: localization.dismiss,
                      color: Colors.white,
                      onPressed: () {
                        setState(() => _dismissedMessage[messageType!] = true);
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
