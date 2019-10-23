import 'package:flutter/material.dart';

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
        shrinkWrap: true,
        children: children,
      ),
    );
  }
}

class AppTabForm extends StatelessWidget {
  const AppTabForm({
    @required this.children,
    @required this.formKey,
    @required this.focusNode,
    @required this.controller,
    @required this.tabBarKey,
  });

  final FocusNode focusNode;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final TabController controller;
  final Key tabBarKey;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: focusNode,
      child: Form(
        key: formKey,
        child: TabBarView(
          key: tabBarKey,
          children: children,
          controller: controller,
        ),
      ),
    );
  }
}
