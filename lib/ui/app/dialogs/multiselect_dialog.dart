// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

void multiselectDialog({
  required BuildContext context,
  required Function(List<String>) onSelected,
  required List<String> options,
  required List<String> selected,
  required List<String> defaultSelected,
  EntityType? entityType,
}) {
  showDialog<AlertDialog>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final localization = AppLocalization.of(context)!;
      return MultiSelectList(
        options: options,
        selected: selected,
        addTitle: localization.addColumn,
        defaultSelected: defaultSelected,
        onSelected: (values) => onSelected(values),
        isDialog: true,
        entityType: entityType,
      );
    },
  );
}

class MultiSelectList extends StatefulWidget {
  const MultiSelectList({
    required this.options,
    required this.selected,
    required this.defaultSelected,
    required this.addTitle,
    required this.onSelected,
    this.liveChanges = false,
    this.prefix,
    this.isDialog = false,
    this.entityType,
  });

  final List<String> options;
  final List<String> selected;
  final List<String> defaultSelected;
  final String addTitle;
  final Function(List<String>) onSelected;
  final bool liveChanges;
  final String? prefix;
  final bool isDialog;
  final EntityType? entityType;

  @override
  MultiSelectListState createState() => MultiSelectListState();
}

class MultiSelectListState extends State<MultiSelectList> {
  late List<String> selected;

  // TODO remove this https://github.com/flutter/flutter/issues/71946
  ScrollController? _controller;

  @override
  void initState() {
    super.initState();
    selected =
        widget.selected.isNotEmpty ? widget.selected : widget.defaultSelected;
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  String? lookupOption(String value) {
    value = value.replaceFirst('\$', '');

    final localization = AppLocalization.of(context);
    final parts = value.split('.');

    // Workaround to sync up the variable with the PDF label
    if (value == InvoiceTotalFields.outstanding) {
      return localization!.balanceDue;
    }

    if (parts.length == 1 || parts[0] == widget.prefix) {
      return localization!.lookup(parts.last);
    } else {
      return localization!.lookup(parts[0]) +
          ' ' +
          localization.lookup(parts[1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;

    final Map<String?, String?> options = {};
    widget.options
        .where((option) => !selected.contains(option))
        .forEach((option) {
      final columnTitle = state.company.getCustomFieldLabel(
          widget.entityType != null
              ? option.replaceFirst('custom', widget.entityType!.snakeCase)
              : option);
      options[option] =
          columnTitle.isEmpty ? lookupOption(option) : columnTitle;
    });
    final keys = options.keys.toList();
    keys.sort((a, b) => lookupOption(a!)!
        .toLowerCase()
        .compareTo(lookupOption(b!)!.toLowerCase()));

    final column = Container(
      width: isMobile(context) ? double.maxFinite : 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppDropdownButton<String>(
            key: ValueKey('__${selected.join(',')}__'),
            labelText: widget.addTitle,
            items: keys.map((option) {
              return DropdownMenuItem(
                child: Text(options[option]!),
                value: option,
              );
            }).toList(),
            value: null,
            onChanged: (dynamic value) {
              if ('$value'.isEmpty) {
                return;
              }

              if (selected.contains(value)) {
                return;
              }

              setState(() {
                selected.add(value);
              });

              if (widget.liveChanges) {
                widget.onSelected(selected);
              }
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: Scrollbar(
              controller: _controller,
              thumbVisibility: true,
              child: ReorderableListView(
                scrollController: _controller,
                padding: const EdgeInsets.only(right: 12),
                children: selected.asMap().entries.map((entry) {
                  final option = entry.value;
                  final columnTitle = state.company.getCustomFieldLabel(
                      widget.entityType != null
                          ? option.replaceFirst(
                              'custom', widget.entityType!.snakeCase)
                          : option);
                  return Padding(
                    key: ValueKey('__${entry.key}_${entry.value}__'),
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() => selected.remove(option));
                            if (widget.liveChanges) {
                              widget.onSelected(selected);
                            }
                          },
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            columnTitle.isEmpty
                                ? lookupOption(option)!
                                : columnTitle,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onReorder: (oldIndex, newIndex) {
                  // https://stackoverflow.com/a/54164333/497368
                  // These two lines are workarounds for ReorderableListView problems
                  if (newIndex > selected.length) {
                    newIndex = selected.length;
                  }
                  if (oldIndex < newIndex) {
                    newIndex--;
                  }

                  setState(() {
                    final field = selected[oldIndex];
                    selected.removeAt(oldIndex);
                    selected.insert(newIndex, field);
                  });

                  if (widget.liveChanges) {
                    widget.onSelected(selected);
                  }
                },
              ),
            ),
          ),
          if (!widget.isDialog)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                      child: Text(localization!.reset.toUpperCase()),
                      onPressed: () {
                        setState(
                            () => selected = widget.defaultSelected.toList());
                        if (widget.liveChanges) {
                          widget.onSelected(selected);
                        }
                      }),
                ],
              ),
            )
        ],
      ),
    );

    return widget.isDialog
        ? AlertDialog(
            semanticLabel: localization!.editColumns,
            title: Text(localization.editColumns),
            content: column,
            actions: [
              TextButton(
                  child: Text(localization.reset.toUpperCase()),
                  onPressed: () {
                    setState(() => selected = widget.defaultSelected.toList());
                    if (widget.liveChanges) {
                      widget.onSelected(selected);
                    }
                  }),
              TextButton(
                  child: Text(localization.cancel.toUpperCase()),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text(localization.save.toUpperCase()),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onSelected(selected);
                  })
            ],
          )
        : column;
  }
}
