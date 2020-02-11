import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

void multiselectDialog(
    {BuildContext context,
    String title,
    List<String> options,
    List<String> selected,
    Function(List<String>) onSelected}) {
  final localization = AppLocalization.of(context);

  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      semanticLabel: title,
      title: Text(title),
      content: _multiselectList(
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

class _multiselectList extends StatefulWidget {
  _multiselectList({this.options, this.selected});

  List<String> options;
  List<String> selected;

  @override
  __multiselectListState createState() => __multiselectListState();
}

class __multiselectListState extends State<_multiselectList> {
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

                final field = selected[oldIndex];
                selected.remove(field);
                selected.insert(newIndex, field);

                //viewModel.onSortChanged(oldIndex, newIndex);
              },
            ),
          ),
        ],
      ),
    );
  }
}
