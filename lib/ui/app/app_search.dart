import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';

class AppSearch extends StatelessWidget {
  final EntityType entityType;
  final String search;
  final Function(String) onSearchChanged;

  AppSearch({
    this.entityType,
    this.search,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return StoreConnector<AppState, ListUIState>(
      converter: (Store<AppState> store) =>
          store.state.getListState(entityType),
      builder: (BuildContext context, listUIState) {
        return listUIState.search == null
            ? Text(localization.lookup(entityType.toString()))
            : Container(
                padding: const EdgeInsets.only(left: 8.0),
                height: 38.0,
                margin: EdgeInsets.only(bottom: 2.0),
                decoration: BoxDecoration(
                    color: listUIState.search != null &&
                            listUIState.search.isNotEmpty
                        ? Colors.yellow[200]
                        : Colors.grey[100],
                    border: Border.all(color: Colors.grey[400], width: 1.0),
                    borderRadius: BorderRadius.circular(6.0)),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.search),
                      ),
                      border: InputBorder.none,
                      hintText: localization.search),
                  autofocus: true,
                  autocorrect: false,
                  onChanged: (value) => onSearchChanged(value),
                ),
              );
      },
    );
  }
}
