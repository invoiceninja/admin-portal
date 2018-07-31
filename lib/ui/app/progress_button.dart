import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';

class ProgressButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final Function onPressed;

  const ProgressButton({
    Key key,
    @required this.label,
    @required this.isLoading,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 2.0),
      child: isLoading
          ? SizedBox(
        width: 100.0,
        child: Center(
          child: SizedBox(
            height: 32.0,
            width: 32.0,
            child: CircularProgressIndicator(
              //valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //strokeWidth: 2.0,
            ),
          ),
        ),
      )
      : ElevatedButton(
        label: label,
        onPressed: () => this.onPressed(),
      ),
    );
  }
}
