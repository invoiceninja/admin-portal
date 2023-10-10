// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class KanbanStatusCard extends StatefulWidget {
  const KanbanStatusCard({
    required this.status,
    required this.onSavePressed,
    required this.isCorrectOrder,
    required this.isSaving,
  });

  final TaskStatusEntity status;
  final Function(Completer<TaskStatusEntity>, String) onSavePressed;
  final bool isCorrectOrder;
  final bool isSaving;

  @override
  _KanbanStatusCardState createState() => _KanbanStatusCardState();
}

class _KanbanStatusCardState extends State<KanbanStatusCard> {
  bool _isEditing = false;
  String _name = '';

  @override
  void initState() {
    super.initState();

    final status = widget.status;
    _name = status.name;
  }

  void _onSavePressed() {
    final localization = AppLocalization.of(context)!;
    final completer =
        snackBarCompleter<TaskStatusEntity>(localization.updatedTaskStatus);
    completer.future.then((value) {
      setState(() {
        _isEditing = false;
      });
    });

    widget.onSavePressed(completer, _name.trim());
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final status = widget.status;

    if (_isEditing) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            DecoratedFormField(
              autofocus: true,
              initialValue: _name,
              minLines: 1,
              maxLines: 1,
              onChanged: (value) => _name = value,
              onSavePressed: (context) => _onSavePressed(),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppTextButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                    });
                  },
                  label: localization!.cancel,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                    child: Text(localization.save),
                    onPressed: widget.isSaving ? null : _onSavePressed,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Opacity(
          opacity: widget.isCorrectOrder ? 1 : .7,
          child: Text(
            status.isNew ? localization!.unassigned : status.name,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      onTap: status.isNew
          ? null
          : () {
              setState(() {
                _isEditing = true;
              });
            },
    );
  }
}
