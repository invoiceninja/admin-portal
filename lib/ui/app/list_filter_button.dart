import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ListFilterButton extends StatelessWidget {
  const ListFilterButton({
    @required this.filter,
    @required this.onFilterPressed,
    this.filterLabel,
  });

  final String filter;
  final Function onFilterPressed;
  final String filterLabel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return StoreBuilder(
      builder: (BuildContext context, Store<AppState> store) {
        return FlatButton(
          child: Text(
            filter == null
                ? (filterLabel ?? localization.filter)
                : localization.close,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => onFilterPressed(filter == null ? '' : null),
        );
      },
    );
  }
}
