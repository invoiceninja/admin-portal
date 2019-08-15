import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    Key key,
    this.isResponsive = false,
    @required this.children,
    this.crossAxisAlignment,
  }) : super(key: key);

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isResponsive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isResponsive
          ? const EdgeInsets.only(top: 12, left: 250, right: 250)
          : const EdgeInsets.all(12),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, top: 16.0, right: 16.0, bottom: 20.0),
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment:
                  crossAxisAlignment ?? CrossAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
