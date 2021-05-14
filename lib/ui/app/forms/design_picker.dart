import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DesignPicker extends StatelessWidget {
  const DesignPicker({
    @required this.onSelected,
    this.label,
    this.initialValue,
  });

  final Function(DesignEntity) onSelected;
  final String label;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final designState = store.state.designState;

    return AppDropdownButton<String>(
      value: initialValue ?? designState.cleanDesign.id,
      onChanged: (dynamic value) => onSelected(designState.map[value]),
      items: designState.list
          .where((designId) =>
              designState.map[designId].isActive || designId == initialValue)
          .map((value) => DropdownMenuItem(
                value: value,
                child: Text(designState.map[value].displayName),
              ))
          .toList(),
      labelText: label ?? localization.design,
    );
  }
}
