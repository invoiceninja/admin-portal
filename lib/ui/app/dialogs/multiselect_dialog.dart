import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

void multiselectDialog(
    {BuildContext context,
    String title,
    String addTitle,
    List<String> options,
    List<String> selected,
    Function(List<String>) onSelected}) {
  final localization = AppLocalization.of(context);

  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      semanticLabel: title,
      title: Text(title),
      content: _MultiSelectList(
        options: options,
        selected: selected,
      ),
      actions: <Widget>[
        FlatButton(
            child: Text(localization.cancel.toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
            }),
        FlatButton(
            child: Text(localization.save.toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
              onSelected(['']);
            })
      ],
    ),
  );
}

class _MultiSelectList extends StatefulWidget {
  const _MultiSelectList({this.options, this.selected, this.addTitle});

  final List<String> options;
  final List<String> selected;
  final String addTitle;

  @override
  _MultiSelectListState createState() => _MultiSelectListState();
}

class _MultiSelectListState extends State<_MultiSelectList> {
  List<String> selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppDropdownButton<String>(
            labelText: widget.addTitle,
            items: widget.options
                .map((option) => DropdownMenuItem(
                      child: Text(option),
                      value: option,
                    ))
                .toList(),
            value: null,
            showBlank: true,
            onChanged: (dynamic value) {
              print('## selected $value');
            },
          ),
          Expanded(
            child: ReorderableListView(
              children: selected
                  .map((option) => Padding(
                        key: ValueKey(option),
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          option,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ))
                  .toList(),
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
                  selected.remove(field);
                  selected.insert(newIndex, field);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
