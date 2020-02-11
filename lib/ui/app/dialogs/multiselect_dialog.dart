import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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
        addTitle: addTitle,
        onSelected: (values) => selected = values,
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
              onSelected(selected);
            })
      ],
    ),
  );
}

class _MultiSelectList extends StatefulWidget {
  const _MultiSelectList({
    @required this.options,
    @required this.selected,
    @required this.addTitle,
    @required this.onSelected,
  });

  final List<String> options;
  final List<String> selected;
  final String addTitle;
  final Function(List<String>) onSelected;

  @override
  _MultiSelectListState createState() => _MultiSelectListState();
}

class _MultiSelectListState extends State<_MultiSelectList> {
  List<String> selected;

  @override
  void initState() {
    super.initState();
    print('## initState: selected - ${widget.selected}');
    selected = widget.selected ?? [];
  }

  /*
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('## initState: selected - ${widget.selected}');
    selected = widget.selected ?? [];
  }

   */

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Container(
      width: isMobile(context) ? double.maxFinite : 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppDropdownButton<String>(
            labelText: widget.addTitle,
            items: widget.options
                .where((option) => !selected.contains(option))
                .map((option) => DropdownMenuItem(
                      child: Text(localization.lookup(option)),
                      value: option,
                    ))
                .toList(),
            value: null,
            onChanged: (dynamic value) {
              if (selected.contains(value)) {
                return;
              }
              setState(() {
                selected.add(value);
                widget.onSelected(selected);
              });
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: ReorderableListView(
              children: selected
                  .map((option) => Padding(
                        key: ValueKey(option),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.reorder),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                localization.lookup(option),
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() => selected.remove(option));
                              },
                            )
                          ],
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
                  widget.onSelected(selected);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
