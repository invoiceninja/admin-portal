import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key key, this.useCard = false, this.height = 200.0})
      : super(key: key);

  final double height;
  final bool useCard;

  @override
  Widget build(BuildContext context) {
    if (useCard) {
      return Padding(
        padding: EdgeInsets.all(14.0),
        child: SizedBox(
          height: 200.0,
          child: Card(
            elevation: 4.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

    return Container(
      height: height,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
