import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ListFilterButton extends StatelessWidget {
  const ListFilterButton({
    this.entityType,
    this.onFilterPressed,
  });

  final EntityType entityType;
  final Function onFilterPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return StoreConnector<AppState, String>(
      converter: (Store<AppState> store) => entityType != null
          ? store.state.getListState(entityType).filter
          : store.state.uiState.filter,
      distinct: true,
      builder: (BuildContext context, filter) {
        return IconButton(
          icon: Icon(filter == null ? Icons.search : Icons.close),
          tooltip: localization.filter,
          onPressed: () => onFilterPressed(filter == null ? '' : null),
        );
      },
    );
  }
}
