// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker({
    Key? key,
    required this.selectedDuration,
    required this.onSelected,
    this.labelText,
    this.allowClearing = false,
  }) : super(key: key);

  final Duration? selectedDuration;
  final Function onSelected;
  final bool allowClearing;
  final String? labelText;

  @override
  _DurationPickerState createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  Duration? _pendingDuration;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFoucsChanged);
  }

  @override
  void didChangeDependencies() {
    _textController.text = widget.selectedDuration != null
        ? formatDuration(widget.selectedDuration)
        : '';

    super.didChangeDependencies();
  }

  void _onFoucsChanged() {
    if (!_focusNode.hasFocus) {
      if (widget.selectedDuration == null && _pendingDuration != null) {
        widget.onSelected(_pendingDuration);
      }

      final duration = _pendingDuration ?? widget.selectedDuration;

      _textController.text = duration != null ? formatDuration(duration) : '';

      setState(() {
        _pendingDuration = null;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFoucsChanged);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedFormField(
      controller: _textController,
      focusNode: _focusNode,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        int seconds = 0;
        if (value.contains(':')) {
          final parts = value.split(':');
          seconds = parseInt(parts[0])! * 60 * 60;
          if (parts[1].length == 1) {
            seconds += parseInt('${parts[1]}0')! * 60;
          } else {
            seconds += parseInt(parts[1])! * 60;
          }
          if (parts.length > 2) {
            seconds += parseInt(parts[2])!;
          }
        } else {
          seconds = (parseDouble(value)! * 60 * 60).round();
        }
        final duration = Duration(seconds: seconds);
        if (widget.selectedDuration != null) {
          widget.onSelected(duration);
        }

        setState(() {
          _pendingDuration = duration;
        });
      },
      decoration: InputDecoration(
          labelText: _pendingDuration != null
              ? formatDuration(_pendingDuration)
              : (widget.labelText ?? ''),
          suffixIcon: widget.allowClearing &&
                  (widget.selectedDuration != null &&
                      widget.selectedDuration!.inSeconds != 0)
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _textController.text = '';
                    widget.onSelected(Duration(seconds: 0));
                  },
                )
              : PopupMenuButton<int>(
                  padding: EdgeInsets.zero,
                  initialValue: null,
                  itemBuilder: (BuildContext context) =>
                      [15, 30, 45, 60, 75, 90, 105, 120]
                          .map((minutes) => PopupMenuItem<int>(
                                child: Text(formatDuration(
                                    Duration(minutes: minutes),
                                    showSeconds: false)),
                                value: minutes,
                              ))
                          .toList(),
                  onSelected: (minutes) {
                    final duration = Duration(minutes: minutes);
                    _textController.text = formatDuration(duration);
                    widget.onSelected(duration);
                  },
                  child: const Icon(Icons.arrow_drop_down),
                )),
    );
  }
}
