import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({
    @required this.onChanged,
  });

  final Function() onChanged;

  static const PERMISSION_MINE = 'user';
  static const PERMISSION_ALL = 'all';
  static const PERMISSION_NONE = 'none';
  static const PERMISSION_CUSTOM = 'custom';

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final userCompany = state.userCompany;

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
                      value: PERMISSION_ALL,
                      addCustom: true,
                      onChanged: (value) {
                        print('## VALUE: $value');
                      },
                    ))
                  ]),
                  DataRow(cells: [
                    DataCell(Text(localization.invoiceSent)),
                    DataCell(_NotificationSelector(
                      value: PERMISSION_ALL,
                      onChanged: (value) {
                        print('## VALUE: $value');
                      },
                    )),
                  ]),
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
    this.addCustom = false,
  });

  final bool addCustom;
  final String value;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AppDropdownButton<String>(
      value: value,
      onChanged: (dynamic value) {
        onChanged(value);
      },
      items: [
        DropdownMenuItem(
          value: NotificationSettings.PERMISSION_NONE,
          child: Text(localization.none),
        ),
        DropdownMenuItem(
          value: NotificationSettings.PERMISSION_MINE,
          child: Text(localization.mine),
        ),
        DropdownMenuItem(
          value: NotificationSettings.PERMISSION_ALL,
          child: Text(localization.all),
        ),
        if (addCustom)
          DropdownMenuItem(
            value: NotificationSettings.PERMISSION_CUSTOM,
            child: Text(localization.custom),
          ),
      ],
    );
  }
}
