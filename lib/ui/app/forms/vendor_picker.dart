// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorPicker extends StatelessWidget {
  const VendorPicker({
    required this.vendorId,
    required this.vendorState,
    required this.onSelected,
    required this.onAddPressed,
    this.autofocus,
  });

  final String vendorId;
  final VendorState vendorState;
  final Function(SelectableEntity?) onSelected;
  final Function(Completer<SelectableEntity> completer) onAddPressed;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return EntityDropdown(
      entityType: EntityType.vendor,
      labelText: localization.vendor,
      entityId: vendorId,
      autofocus: autofocus,
      entityList: memoizedDropdownVendorList(vendorState.map, vendorState.list,
          state.userState.map, state.staticState),
      entityMap: vendorState.map,
      validator: (String? val) => (val ?? '').trim().isEmpty
          ? AppLocalization.of(context)!.pleaseSelectAVendor
          : null,
      onSelected: onSelected,
      onAddPressed: onAddPressed,
      onCreateNew: (completer, name) {
        store.dispatch(SaveVendorRequest(
            vendor: VendorEntity().rebuild((b) => b..name = name),
            completer: completer));
      },
    );
  }
}
