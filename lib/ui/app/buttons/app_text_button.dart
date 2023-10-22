// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    this.label,
    this.onPressed,
    this.isInHeader = false,
    this.color,
  });

  final String? label;
  final Function? onPressed;
  final bool isInHeader;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    Color? primaryColor;
    if (onPressed == null) {
      //
    } else if (color != null) {
      primaryColor = color;
    } else if (isInHeader) {
      primaryColor = state.headerTextColor;
    } else if (state.prefState.enableDarkMode) {
      primaryColor = Colors.white;
    } else {
      primaryColor = Colors.black87;
    }

    final ButtonStyle flatButtonStyle =
        TextButton.styleFrom(foregroundColor: primaryColor);

    return TextButton(
      style: flatButtonStyle,
      onPressed: onPressed as void Function()?,
      child: Text(label!),
    );
  }
}
