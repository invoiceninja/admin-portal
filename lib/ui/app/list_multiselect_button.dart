import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ListMultiselectButton extends StatelessWidget {
  const ListMultiselectButton(
      {@required this.mode, @required this.onPressed, this.key});

  final ListMultiselectButtonMode mode;
  final Function onPressed;
  final Key key;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return FlatButton(
      key: key,
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
