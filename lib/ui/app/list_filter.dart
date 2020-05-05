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
  FocusNode _focusNode;
  String _placeholder = '';

  @override
  void initState() {
    super.initState();
    _filterController = TextEditingController();
    _focusNode = FocusNode()..addListener(onFocusChanged);
    _placeholder = widget.placeholder;
  }

  void onFocusChanged() {
    setState(() {
      _placeholder = _focusNode.hasFocus ? '' : widget.placeholder;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _filterController.text = widget.filter;
  }

  @override
  void dispose() {
    _filterController.dispose();
    _focusNode.removeListener(onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).primaryTextTheme.bodyText1.color;
    final isFilterSet = (widget.filter ?? '').isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Container(
        padding: const EdgeInsets.only(left: 8.0),
        height: 40,
        margin: EdgeInsets.only(bottom: 2.0),
        decoration: BoxDecoration(
          color: isFilterSet
              ? convertHexStringToColor(
                  kDefaultBorderColor) // TODO set color here
              : convertHexStringToColor(kDefaultBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: TextField(
          focusNode: _focusNode,
          textAlign: _focusNode.hasFocus ? TextAlign.start : TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8, right: 8, bottom: 6),
            suffixIcon: _focusNode.hasFocus
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
            border: InputBorder.none,
            hintText: _placeholder,
          ),
          autocorrect: false,
          onChanged: (value) {
            widget.onFilterChanged(value);
          },
          controller: _filterController,
        ),
      ),
    );
  }
}
