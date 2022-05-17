// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/platforms.dart';

class AppScrollbar extends StatefulWidget {
  const AppScrollbar({
    @required this.child,
    @required this.controller,
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
    if (isMobile(context)) {
      return Scrollbar(
        child: widget.child,
        controller: widget.controller,
      );
    } else {
      return MouseRegion(
        onEnter: (event) => setState(() => _isHovered = true),
        onExit: (event) => setState(() => _isHovered = false),
        child: Scrollbar(
          child: widget.child,
          controller: widget.controller,
          trackVisibility: isDesktop(context) && _isHovered,
        ),
      );
    }
  }
}
