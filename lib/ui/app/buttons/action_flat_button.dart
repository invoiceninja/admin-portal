import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ActionFlatButton extends StatelessWidget {
  const ActionFlatButton({
    this.onPressed,
    this.tooltip,
    this.isSaving = false,
    this.isVisible = true,
    this.isHeader = false,
  });

  final bool isSaving;
  final bool isVisible;
  final Function onPressed;
  final String tooltip;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    if (!isVisible) {
      return Container();
    }

    if (isSaving) {
      return SizedBox(
        width: 88,
        child: IconButton(
          onPressed: null,
          icon: SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  state.hasAccentColor || state.prefState.enableDarkMode
                      ? Colors.white
                      : state.accentColor),
            ),
          ),
        ),
      );
    }

    return FlatButton(
      child: Text(
        tooltip,
        style: isHeader ? TextStyle(color: store.state.headerTextColor) : null,
      ),
      onPressed: onPressed,
    );
  }
}
