import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class RefreshIconButton extends StatelessWidget {
  const RefreshIconButton({
    this.isSaving,
    this.isDirty,
    this.onPressed,
    this.isVisible,
    this.tooltip,
    this.icon,
  });

  final bool isSaving;
  final bool isDirty;
  final bool isVisible;
  final Function onPressed;
  final String tooltip;
  final IconData icon;

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

    final state = StoreProvider.of<AppState>(context).state;

    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(
        icon,
        color: isDirty
            ? (state.uiState.enableDarkMode
                ? Theme.of(context).accentColor
                : Colors.yellowAccent)
            : Colors.white,
      ),
    );
  }
}
