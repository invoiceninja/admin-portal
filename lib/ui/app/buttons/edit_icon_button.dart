// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EditIconButton extends StatelessWidget {
  const EditIconButton({
    this.onPressed,
    this.isVisible,
  });

  final bool? isVisible;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);

    if (!isVisible!) {
      return Container();
    }

    return TextButton(
      child: Text(
        localization!.edit,
        style: TextStyle(color: store.state.headerTextColor),
      ),
      onPressed: onPressed as void Function()?,
    );
  }
}
