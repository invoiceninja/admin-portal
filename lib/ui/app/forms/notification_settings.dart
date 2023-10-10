// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({
    required this.user,
    required this.onChanged,
  });

  final UserEntity user;
  final Function(String, List<String>) onChanged;

  static const NOTIFY_OWNED = 'user';
  static const NOTIFY_ALL = 'all';
  static const NOTIFY_NONE = 'none';

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final localization = AppLocalization.of(context)!;
    final notifications = user.userCompany?.notifications ??
        BuiltMap<String, BuiltList<String>>();
    final BuiltList<String> emailNotifications =
        notifications.containsKey(kNotificationChannelEmail)
            ? notifications[kNotificationChannelEmail]!
            : BuiltList<String>();
    final hasMultipleUsers = state.userState.list.length > 1 || user.isNew;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FormCard(
          isLast: true,
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
                    DataCell(Text(localization.allEvents)),
                    DataCell(_NotificationSelector(
                      value: emailNotifications.contains(kNotificationsAll)
                          ? NOTIFY_ALL
                          : emailNotifications.contains(kNotificationsAllUser)
                              ? NOTIFY_OWNED
                              : null,
                      showNoneAsCustom: true,
                      hasMultipleUsers: hasMultipleUsers,
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
                          kNotificationsQuoteCreated,
                          kNotificationsQuoteSent,
                          kNotificationsQuoteViewed,
                          kNotificationsQuoteApproved,
                          kNotificationsQuoteExpired,
                        ].contains(eventType) &&
                        !state.company.isModuleEnabled(EntityType.quote)) {
                      return false;
                    } else if ([
                          kNotificationsCreditCreated,
                          kNotificationsCreditSent,
                          kNotificationsCreditViewed,
                        ].contains(eventType) &&
                        !state.company.isModuleEnabled(EntityType.credit)) {
                      return false;
                    } else if ([
                          kNotificationsPurchaseOrderCreated,
                          kNotificationsPurchaseOrderSent,
                          kNotificationsPurchaseOrderViewed,
                          kNotificationsPurchaseOrderAccepted,
                        ].contains(eventType) &&
                        !state.company
                            .isModuleEnabled(EntityType.purchaseOrder)) {
                      return false;
                    } else if ([
                          kNotificationsInventoryThreshold,
                        ].contains(eventType) &&
                        !state.company.stockNotification) {
                      return false;
                    }

                    return true;
                  }).map((eventType) {
                    String value;
                    bool isAllEnabled = false;
                    if (emailNotifications.contains(kNotificationsAll)) {
                      value = NOTIFY_ALL;
                      isAllEnabled = true;
                    } else if (emailNotifications
                        .contains(kNotificationsAllUser)) {
                      value = NOTIFY_OWNED;
                      isAllEnabled = true;
                    } else if (emailNotifications
                        .contains('${eventType}_all')) {
                      value = NOTIFY_ALL;
                    } else if (emailNotifications
                        .contains('${eventType}_user')) {
                      value = NOTIFY_OWNED;
                    } else {
                      value = NOTIFY_NONE;
                    }
                    return DataRow(cells: [
                      // workaround for mistake in translations
                      DataCell(Text(eventType == kNotificationsInvoiceSent
                          ? localization.invoiceSentNotificationLabel
                          : localization.lookup(eventType))),
                      DataCell(isAllEnabled
                          ? value == NOTIFY_ALL
                              ? IconText(
                                  text: hasMultipleUsers
                                      ? localization.allRecords
                                      : localization.enabled,
                                  icon: hasMultipleUsers
                                      ? Icons.supervised_user_circle
                                      : Icons.check_circle,
                                )
                              : IconText(
                                  text: localization.ownedByUser,
                                  icon: Icons.account_circle)
                          : _NotificationSelector(
                              value: value,
                              hasMultipleUsers: hasMultipleUsers,
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
    required this.value,
    required this.onChanged,
    required this.hasMultipleUsers,
    this.showNoneAsCustom = false,
  });

  final String? value;
  final Function(String) onChanged;
  final bool hasMultipleUsers;
  final bool showNoneAsCustom;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AppDropdownButton<String>(
      value: value,
      onChanged: (dynamic value) {
        if (value == null || value.isEmpty) {
          return;
        }
        onChanged(value);
      },
      items: [
        DropdownMenuItem(
          value: NotificationSettings.NOTIFY_ALL,
          child: IconText(
            text: hasMultipleUsers
                ? localization!.allRecords
                : localization!.enabled,
            icon: hasMultipleUsers
                ? Icons.supervised_user_circle
                : Icons.check_circle,
          ),
        ),
        if (hasMultipleUsers)
          DropdownMenuItem(
            value: NotificationSettings.NOTIFY_OWNED,
            child: IconText(
                text: localization.ownedByUser, icon: Icons.account_circle),
          ),
        DropdownMenuItem(
          value: NotificationSettings.NOTIFY_NONE,
          child: IconText(
            text: showNoneAsCustom
                ? localization.custom
                : hasMultipleUsers
                    ? localization.none
                    : localization.disabled,
            icon: showNoneAsCustom
                ? Icons.arrow_drop_down_circle
                : Icons.do_not_disturb_alt,
          ),
        ),
      ],
    );
  }
}
