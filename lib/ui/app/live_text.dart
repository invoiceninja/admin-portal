// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:window_manager/window_manager.dart';

class LiveText extends StatefulWidget {
  const LiveText(
    this.value, {
    this.style,
    this.duration,
    this.maxLines = 1,
  });

  final Duration? duration;
  final Function value;
  final TextStyle? style;
  final int maxLines;

  @override
  _LiveTextState createState() => _LiveTextState();
}

class _LiveTextState extends State<LiveText> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      widget.duration ?? Duration(milliseconds: 500),
      (Timer timer) async {
        if (isDesktopOS()) {
          final isFocused = await windowManager.isFocused();
          if (!isFocused) {
            return;
          }
        }

        if (mounted) {
          setState(() => false);
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String value = widget.value() ?? '';

    if (value.isEmpty) {
      return SizedBox();
    }

    return Text(
      value,
      style: widget.style,
      maxLines: widget.maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
