import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    this.label,
    this.onPressed,
    this.isInHeader = false,
    this.color,
  });

  final String label;
  final Function onPressed;
  final bool isInHeader;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: onPressed == null
          ? null
          : color != null
              ? color
              : isInHeader
                  ? state.headerTextColor
                  : state.prefState.enableDarkMode
                      ? Colors.white
                      : Colors.black87,
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
