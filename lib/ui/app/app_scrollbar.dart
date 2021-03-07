import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class AppScrollbar extends StatefulWidget {
  const AppScrollbar({
    this.child,
    this.controller,
  });
  final Widget child;
  final ScrollController controller;

  @override
  _AppScrollbarState createState() => _AppScrollbarState();
}

class _AppScrollbarState extends State<AppScrollbar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: Scrollbar(
        child: widget.child,
        controller: widget.controller,
        isAlwaysShown: isDesktop(context) && _isHovered,
      ),
    );
  }
}
