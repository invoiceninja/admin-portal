import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class UserPicker extends StatelessWidget {
  const UserPicker({this.userId, this.onChanged});

  final String userId;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final localization = AppLocalization.of(context);

    if (!state.userCompany.isAdmin) {
      return SizedBox();
    }

    final users = memoizedUserList(state.userState.map);

    if (users.length < 10) {
      return AppDropdownButton(
        labelText: localization.users,
        value: userId,
        onChanged: (userId) => onChanged(userId),
        items: users.map((userId) => DropdownMenuItem(
          child: Text(state.userState.map[userId]?.fullName ?? ''),
          value: userId,
        )).toList(),
      );
    } else {
      return EntityDropdown(
        key: ValueKey('__user_${userId}__'),
        labelText: localization.user,
        entityType: EntityType.user,
        allowClearing: true,
        onSelected: (user) => onChanged(user.id),
        initialValue: state.userState.map[userId]?.fullName,
        entityMap: state.userState.map,
        entityList: users,
      );
    }
  }
}
