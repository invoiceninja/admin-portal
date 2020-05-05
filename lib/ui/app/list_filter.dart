import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';

class ListFilter extends StatefulWidget {
  const ListFilter({
    Key key,
    @required this.filter,
    @required this.title,
    @required this.onFilterChanged,
    this.filterLabel,
  }) : super(key: key);

  final String filter;
  final String title;
  final Function(String) onFilterChanged;
  final String filterLabel;

  @override
  _ListFilterState createState() => new _ListFilterState();
}

class _ListFilterState extends State<ListFilter> {
  TextEditingController _filterController;

  @override
  void initState() {
    super.initState();
    _filterController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _filterController.text = widget.filter;
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 8.0),
      height: 44,
      margin: EdgeInsets.only(bottom: 2.0),
      decoration: BoxDecoration(
        color: convertHexStringToColor(kDefaultBorderColor),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: (widget.filter ?? '').isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      widget.onFilterChanged(null);
                      _filterController.text = '';
                    },
                  )
                : Icon(Icons.search,
                    color: Theme.of(context).primaryTextTheme.bodyText1.color),
          ),
          border: InputBorder.none,
          hintText: widget.filterLabel ?? localization.filter,
        ),
        autocorrect: false,
        onChanged: (value) {
          widget.onFilterChanged(value);
        },
        controller: _filterController,
      ),
    );
  }
}
