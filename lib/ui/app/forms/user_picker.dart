import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';

class UserPicker extends StatelessWidget {
  const UserPicker({
    @required this.userId,
    @required this.onChanged,
    this.userIds,
  });

  final String userId;
  final Function(String) onChanged;
  final List<String> userIds;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;

    if (!state.userCompany.isAdmin) {
      return SizedBox();
    }

    List<String> ids;
    if (userIds == null) {
      ids = memoizedUserList(state.userState.map);

      if (ids.length == 1) {
        return SizedBox();
      }
    } else {
      ids = userIds;
    }

    return DynamicSelector(
      onChanged: onChanged,
      entityType: EntityType.user,
      entityId: userId,
      entityIds: ids,
    );
  }
}
