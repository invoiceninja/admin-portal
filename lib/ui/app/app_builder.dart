import 'package:flutter/material.dart';

class AppBuilder extends StatefulWidget {
  const AppBuilder({Key key, this.builder}) : super(key: key);
  final Function(BuildContext) builder;

  @override
  AppBuilderState createState() => new AppBuilderState();

  static AppBuilderState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<AppBuilderState>());
  }
}

class AppBuilderState extends State<AppBuilder> {
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      child: widget.builder(context),
      focusNode: _focusNode,
      onKey: (event) {
        print(
            'onKey: ${event.logicalKey.keyLabel}, focus: ${_focusNode.hasFocus}');
      },
    );
  }
}
