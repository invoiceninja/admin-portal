import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_flat_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SaveCancelButtons extends StatelessWidget {
  const SaveCancelButtons({
    this.onSavePressed,
    this.onCancelPressed,
    this.saveLabel,
    this.cancelLabel,
    this.isHeader = true,
    this.isSaving = false,
  });

  final bool isSaving;
  final String saveLabel;
  final String cancelLabel;
  final bool isHeader;
  final Function(BuildContext) onCancelPressed;
  final Function(BuildContext) onSavePressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);

    return Row(
      children: <Widget>[
        if (onCancelPressed != null && !isSaving)
          Builder(builder: (BuildContext context) {
            return FlatButton(
              child: Text(
                cancelLabel ?? localization.cancel,
                style: isHeader
                    ? TextStyle(color: store.state.headerTextColor)
                    : null,
                //style: TextStyle(color: Colors.white),
              ),
              onPressed: () => onCancelPressed(context),
            );
          }),
        SizedBox(width: 10),
        Builder(builder: (BuildContext context) {
          return ActionFlatButton(
            tooltip: saveLabel ?? localization.save,
            isVisible: true,
            isSaving: isSaving,
            isHeader: isHeader,
            onPressed: () => onSavePressed(context),
          );
        }),
      ],
    );
  }
}
