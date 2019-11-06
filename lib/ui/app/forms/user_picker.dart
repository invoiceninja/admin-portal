import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
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
    return EntityDropdown(
        key: ValueKey('__user_${userId}__'),
        labelText: localization.user,
        entityType: EntityType.user,
        allowClearing: true,
        onSelected: (user) => onChanged(user.id),
        initialValue: state.userState.map[userId]?.fullName,
        entityMap: state.userState.map,
    );
  }
}
