import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({
    @required this.user,
    @required this.onChanged,
  });

  final UserEntity user;
  final Function(String, List<String>) onChanged;

  static const NOTIFY_OWNED = 'user';
  static const NOTIFY_ALL = 'all';
  static const NOTIFY_NONE = 'none';

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final localization = AppLocalization.of(context);
    final notifications =
        user.userCompany.notifications ?? BuiltMap<String, BuiltList<String>>();
    final BuiltList<String> emailNotifications =
        notifications.containsKey(kNotificationChannelEmail)
            ? notifications[kNotificationChannelEmail]
            : BuiltList<String>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FormCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DataTable(
                columns: [
                  DataColumn(
                    label: SizedBox(),
                  ),
                  DataColumn(
                    label: Text(localization.email),
                  ),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(localization.all)),
                    DataCell(_NotificationSelector(
                      value: emailNotifications.contains(kNotificationsAll)
                          ? NOTIFY_ALL
                          : emailNotifications.contains(kNotificationsAllUser)
                              ? NOTIFY_OWNED
                              : null,
                      onChanged: (value) {
                        List<String> options = [];
                        if (value == NOTIFY_ALL) {
                          options = [kNotificationsAll];
                        } else if (value == NOTIFY_OWNED) {
                          options = [kNotificationsAllUser];
                        }
                        onChanged(kNotificationChannelEmail, options);
                      },
                    ))
                  ]),
                  ...kNotificationEvents.where((eventType) {
                    if ([
                          kNotificationsQuoteSent,
                          kNotificationsQuoteViewed,
                          kNotificationsQuoteApproved
                        ].contains(eventType) &&
                        !state.company.isModuleEnabled(EntityType.quote)) {
                      return false;
                    } else if ([
                          kNotificationsCreditSent,
                          kNotificationsCreditViewed,
                        ].contains(eventType) &&
                        !state.company.isModuleEnabled(EntityType.credit)) {
                      return false;
                    }

                    return true;
                  }).map((eventType) {
                    String value;
                    if (emailNotifications.contains('${eventType}_all')) {
                      value = NOTIFY_ALL;
                    } else if (emailNotifications
                        .contains('${eventType}_user')) {
                      value = NOTIFY_OWNED;
                    } else {
                      value = NOTIFY_NONE;
                    }
                    return DataRow(cells: [
                      DataCell(Text(localization.lookup(eventType))),
                      DataCell(_NotificationSelector(
                        value: value,
                        onChanged: (value) {
                          final options = emailNotifications.toList();
                          options.remove('${eventType}_all');
                          options.remove('${eventType}_user');
                          if (value == NOTIFY_ALL) {
                            options.add('${eventType}_all');
                          } else if (value == NOTIFY_OWNED) {
                            options.add('${eventType}_user');
                          }
                          onChanged(kNotificationChannelEmail, options);
                        },
                      )),
                    ]);
                  }).toList(),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class _NotificationSelector extends StatelessWidget {
  const _NotificationSelector({
    @required this.value,
    @required this.onChanged,
  });

  final String value;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AppDropdownButton<String>(
      value: value,
      //enabled: false,
      onChanged: (dynamic value) {
        if (value == null || value.isEmpty) {
          return;
        }
        onChanged(value);
      },
      items: [
        DropdownMenuItem(
          value: NotificationSettings.NOTIFY_ALL,
          child: Text(localization.all),
        ),
        DropdownMenuItem(
          value: NotificationSettings.NOTIFY_OWNED,
          child: Text(localization.owned),
        ),
        DropdownMenuItem(
          value: NotificationSettings.NOTIFY_NONE,
          child: Text(localization.none),
        ),
      ],
    );
  }
}
