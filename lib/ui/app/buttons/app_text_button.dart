import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    this.label,
    this.onPressed,
  });

  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          label,
          style: TextStyle(
            color: state.prefState.enableDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
