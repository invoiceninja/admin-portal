import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';

class EditIconButton extends StatelessWidget {
  EditIconButton({
    this.onPressed,
    this.isVisible,
  });

  final bool isVisible;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    if (!isVisible) {
      return Container();
    }

    return IconButton(
      onPressed: onPressed,
      tooltip: localization.edit,
      icon: const Icon(Icons.edit),
    );
  }
}
