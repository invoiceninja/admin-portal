import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';

class ElevatedButton extends StatelessWidget {
  const ElevatedButton(
      {@required this.label, @required this.onPressed, this.icon, this.color});

  final Color color;
  final IconData icon;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    //final state = StoreProvider.of<AppState>(context).state;

    return RaisedButton(
      color: color ?? Theme.of(context).buttonColor,
      child: icon != null
          ? IconText(
              icon: icon,
              text: label,
            )
          : Text(label),
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      //textColor: Colors.white,
      elevation: 4.0,
      onPressed: () => this.onPressed(),
    );
  }
}
