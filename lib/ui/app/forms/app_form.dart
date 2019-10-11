import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class AppForm extends StatelessWidget {
  const AppForm({
    @required this.children,
    @required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: children,
      ),
    );
  }
}
