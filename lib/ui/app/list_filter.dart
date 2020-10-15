import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ListFilter extends StatefulWidget {
  const ListFilter({
    Key key,
    @required this.entityType,
    @required this.filter,
    @required this.onFilterChanged,
    @required this.entityIds,
  }) : super(key: key);

  final EntityType entityType;
  final String filter;
  final Function(String) onFilterChanged;
  final List<String> entityIds;

  @override
  _ListFilterState createState() => new _ListFilterState();
}

class _ListFilterState extends State<ListFilter> {
  TextEditingController _filterController;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _filterController = TextEditingController();
    _focusNode = FocusNode()..addListener(onFocusChanged);
  }

  void onFocusChanged() {
    setState(() {});
  }

  String get _getPlaceholder {
    if (_focusNode.hasFocus) {
      return '';
    }

    final localization = AppLocalization.of(context);
    final count = widget.entityIds.length;

    final isSingle = count == 1 ||
        [EntityType.dashboard, EntityType.settings].contains(widget.entityType);
    final key = toSnakeCase(
        isSingle ? widget.entityType.toString() : widget.entityType.plural);
    final placeholder = localization.lookup(
        widget.entityType == EntityType.dashboard
            ? 'search_company'
            : 'search_$key');

    return isSingle
        ? placeholder
        : placeholder.replaceFirst(
            ':count',
            formatNumber(count.toDouble(), context,
                formatNumberType: FormatNumberType.int));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _filterController.text = widget.filter;

    if (widget.filter != null) {
      _focusNode.requestFocus();
    }
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
    final textColor = Theme.of(context).textTheme.bodyText1.color;
    final isFilterSet = (widget.filter ?? '').isNotEmpty;
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final enableDarkMode = state.prefState.enableDarkMode;

    Color color;
    if (enableDarkMode) {
      color = convertHexStringToColor(
          isFilterSet ? kDefaultDarkBorderColor : kDefaultDarkBorderColor);
    } else {
      color = convertHexStringToColor(
          isFilterSet ? kDefaultLightBorderColor : kDefaultLightBorderColor);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Container(
        padding: const EdgeInsets.only(left: 8.0),
        height: 40,
        margin: EdgeInsets.only(bottom: 2.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: TextField(
          focusNode: _focusNode,
          textAlign: _filterController.text.isNotEmpty || _focusNode.hasFocus
              ? TextAlign.start
              : TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8, right: 8, bottom: 6),
            suffixIcon: _filterController.text.isNotEmpty || _focusNode.hasFocus
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: textColor,
                    ),
                    onPressed: () {
                      _filterController.text = '';
                      _focusNode.unfocus(
                          disposition:
                              UnfocusDisposition.previouslyFocusedChild);
                      widget.onFilterChanged(null);
                    },
                  )
                : Icon(Icons.search, color: textColor),
            border: InputBorder.none,
            hintText: _getPlaceholder,
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
