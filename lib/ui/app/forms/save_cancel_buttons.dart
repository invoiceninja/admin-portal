import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_flat_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SaveCancelButtons extends StatelessWidget {
  const SaveCancelButtons({
    this.onSavePressed,
    this.onCancelPressed,
    this.saveLabel,
    this.isSaving = false,
  });

  final bool isSaving;
  final String saveLabel;
  final Function(BuildContext) onCancelPressed;
  final Function(BuildContext) onSavePressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Row(
      children: <Widget>[
        if (onCancelPressed != null)
          Builder(builder: (BuildContext context) {
            return FlatButton(
              child: Text(
                localization.cancel,
              ),
              onPressed: () => onCancelPressed(context),
            );
          }),
        Builder(builder: (BuildContext context) {
          return ActionFlatButton(
            tooltip: saveLabel ?? localization.save,
            isVisible: true,
            isDirty: true,
            isSaving: isSaving,
            onPressed: () => onSavePressed(context),
          );
        }),
      ],
    );
  }
}
