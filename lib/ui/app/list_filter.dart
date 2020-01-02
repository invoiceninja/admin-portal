import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

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
  final _filterController = TextEditingController();

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

    return StoreConnector<AppState, AppState>(
      converter: (Store<AppState> store) => store.state,
      builder: (BuildContext context, state) {
        final bool enableDarkMode = state.prefState.enableDarkMode;
        return widget.filter == null
            ? Text('${widget.title ?? ''}')
            : Container(
                padding: const EdgeInsets.only(left: 8.0),
                height: 38.0,
                margin: EdgeInsets.only(bottom: 2.0),
                decoration: BoxDecoration(
                    color: widget.filter != null && widget.filter.isNotEmpty
                        ? enableDarkMode
                            ? Colors.yellow.shade900
                            : Colors.yellow.shade200
                        : Theme.of(context).backgroundColor,
                    border: Border.all(
                        color: enableDarkMode
                            ? Colors.grey.shade600
                            : Colors.grey.shade400,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(6.0)),
                child: TextField(
                  decoration: InputDecoration(
                      /*
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.search),
                      ),
                     */
                      border: InputBorder.none,
                      hintText: widget.filterLabel ?? localization.filter),
                  autofocus: true,
                  autocorrect: false,
                  onChanged: (value) {
                    widget.onFilterChanged(value);
                  },
                  controller: _filterController,
                ),
              );
      },
    );
  }
}
