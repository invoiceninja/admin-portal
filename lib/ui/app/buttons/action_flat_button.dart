import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ActionFlatButton extends StatelessWidget {
  const ActionFlatButton({
    this.onPressed,
    this.tooltip,
    this.isSaving = false,
    this.isDirty = false,
    this.isVisible = true,
  });

  final bool isSaving;
  final bool isDirty;
  final bool isVisible;
  final Function onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
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
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    final state = StoreProvider.of<AppState>(context).state;

    return FlatButton(
      child: Text(
        tooltip,
        style: TextStyle(
            color: isDirty
                ? (state.prefState.enableDarkMode
                    ? Theme.of(context).accentColor
                    : Colors.yellowAccent)
                : Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
