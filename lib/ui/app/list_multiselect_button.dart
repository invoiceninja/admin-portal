import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ListMultiselectButton extends StatelessWidget {
  const ListMultiselectButton({@required this.mode, @required this.onPressed});

  final ListMultiselectButtonMode mode;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return FlatButton(
      child: Text(
        mode == ListMultiselectButtonMode.DONE
            ? localization.done
            : localization.cancel,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}

enum ListMultiselectButtonMode { DONE, CANCEL }
