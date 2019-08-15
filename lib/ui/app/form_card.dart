import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    Key key,
    @required this.children,
    this.crossAxisAlignment,
  }) : super(key: key);

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: calculateLayout(context) == AppLayout.mobile
          ? const EdgeInsets.all(12)
          : const EdgeInsets.only(top: 12, left: 250, right: 250),
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
