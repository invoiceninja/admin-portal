import 'package:flutter/material.dart';

class ProgressButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final bool isDirty;
  final Function onPressed;

  ProgressButton({
    Key key,
    @required this.label,
    @required this.isLoading,
    @required this.onPressed,
    @required this.isDirty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    if (! isDirty) {
      return Container();
    }
    */

    return Padding(
      padding: EdgeInsets.only(left: 14.0, right: 14.0, top: 2.0),
      child: this.isLoading
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
          : RaisedButton(
        child: Text(this.label),
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
        //color: Colors.lightBlueAccent,
        //color: const Color(0xFF005090),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        elevation: 4.0,
        onPressed: () => this.onPressed(),
      ),
    );
  }
}
