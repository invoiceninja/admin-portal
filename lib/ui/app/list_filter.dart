import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';

class ListFilter extends StatefulWidget {
  const ListFilter({
    Key key,
    @required this.placeholder,
    @required this.filter,
    @required this.onFilterChanged,
  }) : super(key: key);

  final String placeholder;
  final String filter;
  final Function(String) onFilterChanged;


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
    final textColor = Theme.of(context).primaryTextTheme.bodyText1.color;
    final isFilterSet = (widget.filter ?? '').isNotEmpty;
    return Container(
      padding: const EdgeInsets.only(left: 8.0),
      height: 44,
      margin: EdgeInsets.only(bottom: 2.0),
      decoration: BoxDecoration(
        color: isFilterSet
            ? convertHexStringToColor(
                kDefaultBorderColor) // TODO set color here
            : convertHexStringToColor(kDefaultBorderColor),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: isFilterSet
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: textColor,
                    ),
                    onPressed: () {
                      widget.onFilterChanged(null);
                      _filterController.text = '';
                    },
                  )
                : Icon(Icons.search, color: textColor),
          ),
          border: InputBorder.none,
          hintText: widget.placeholder ?? localization.search,
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
