import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    Key key,
    @required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, top: 16.0, right: 16.0, bottom: 20.0),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
