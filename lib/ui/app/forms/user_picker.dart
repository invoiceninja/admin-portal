import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';

class UserPicker extends StatelessWidget {
  const UserPicker({this.userId, this.onChanged});

  final String userId;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;

    if (!state.userCompany.isAdmin) {
      return SizedBox();
    }

    if (state.userState.list.length == 1) {
      return SizedBox();
    }

    return DynamicSelector(
      onChanged: onChanged,
      entityType: EntityType.user,
      entityId: userId,
      entityIds: memoizedUserList(state.userState.map),
    );
  }
}
