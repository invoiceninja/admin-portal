import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';

class SaveIconButton extends StatelessWidget {
  const SaveIconButton({
    this.isSaving,
    this.isDirty,
    this.onPressed,
    this.isVisible,
  });

  final bool isSaving;
  final bool isDirty;
  final bool isVisible;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    if (!isVisible) {
      return Container();
    }

    if (isSaving) {
      return IconButton(
        onPressed: null,
        icon: SizedBox(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    return IconButton(
      onPressed: onPressed,
      tooltip: localization.save,
      icon: Icon(
        Icons.cloud_upload,
        color: isDirty ? Colors.yellowAccent : Colors.white,
      ),
    );
  }
}
