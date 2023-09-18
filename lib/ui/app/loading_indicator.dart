// Flutter imports:
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key, this.useCard = false, this.height})
      : super(key: key);

  final double? height;
  final bool useCard;

  @override
  Widget build(BuildContext context) {
    if (useCard) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          height: 200.0,
          width: double.infinity,
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
      height: height ?? double.infinity,
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
