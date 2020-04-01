import 'package:flutter/material.dart';

class ActionFlatButton extends StatelessWidget {
  const ActionFlatButton({
    this.onPressed,
    this.tooltip,
    this.isSaving = false,
    this.isVisible = true,
  });

  final bool isSaving;
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

    return FlatButton(
      child: Text(
        tooltip,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
