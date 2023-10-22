// https://github.com/Ahmadre/multiselect

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class _TheState {}

var _theState = RM.inject(() => _TheState());

class _SelectRow extends StatelessWidget {
  const _SelectRow({
    Key? key,
    required this.onChange,
    required this.selected,
    required this.child,
  }) : super(key: key);

  final Function(bool) onChange;
  final bool selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      title: child,
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      onTap: () {
        onChange(!selected);
        _theState.notify();
      },
    );

    /*
    return CheckboxListTile(
      value: selected,
      title: child,
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (x) {
        onChange(x);
        _theState.notify();
      },
    );
    */
  }
}

///
/// A Dropdown multiselect menu
///
///
class DropDownMultiSelect extends StatefulWidget {
  const DropDownMultiSelect({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.whenEmpty,
    this.childBuilder,
    this.menuItembuilder,
    this.isDense = false,
    this.enabled = true,
    this.decoration,
    this.validator,
    this.readOnly = false,
    this.height = 100,
    this.fadeoutColor,
  }) : super(key: key);

  /// The options form which a user can select
  final List? options;

  /// Selected Values
  final List selectedValues;

  /// This function is called whenever a value changes
  final ValueChanged<List> onChanged;

  /// defines whether the field is dense
  final bool isDense;

  /// defines whether the widget is enabled;
  final bool enabled;

  /// Input decoration
  final InputDecoration? decoration;

  /// this text is shown when there is no selection
  final String whenEmpty;

  /// a function to build custom childern
  final Widget Function(List selectedValues)? childBuilder;

  /// a function to build custom menu items
  final Widget Function(dynamic option)? menuItembuilder;

  /// a function to validate
  final String Function(dynamic selectedOptions)? validator;

  /// defines whether the widget is read-only
  final bool readOnly;

  final double height;

  final Color? fadeoutColor;

  @override
  _DropDownMultiSelectState createState() => _DropDownMultiSelectState();
}

class _DropDownMultiSelectState extends State<DropDownMultiSelect> {
  Color? fadeoutColor = Colors.white;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.fadeoutColor == null) {
        fadeoutColor = Theme.of(context).scaffoldBackgroundColor;
      } else {
        fadeoutColor = widget.fadeoutColor;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              _theState.rebuild(
                () => widget.childBuilder != null
                    ? widget.childBuilder!(widget.selectedValues)
                    : Align(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                                  .copyWith(right: 32),
                          child: widget.menuItembuilder != null &&
                                  widget.selectedValues.isNotEmpty
                              ? ClipRRect(
                                  child: SingleChildScrollView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: widget.selectedValues
                                          .map((dynamic e) {
                                        if (widget.selectedValues.indexOf(e) <
                                            widget.selectedValues.length - 1) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              widget.menuItembuilder!(e),
                                              Text(',')
                                            ],
                                          );
                                        }
                                        return widget.menuItembuilder!(e);
                                      }).toList(),
                                    ),
                                  ),
                                )
                              : Text(widget.selectedValues.isNotEmpty
                                  ? widget.selectedValues
                                      .map((dynamic e) => e.toString())
                                      .reduce((a, b) => a + ' , ' + b)
                                  : widget.whenEmpty),
                        ),
                        alignment: Alignment.centerLeft),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButtonFormField<dynamic>(
                  iconEnabledColor: Colors.white,
                  validator: widget.validator != null ? widget.validator : null,
                  decoration: widget.decoration != null
                      ? widget.decoration
                      : InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                        ),
                  isDense: true,
                  onChanged: widget.enabled ? (dynamic x) {} : null,
                  value: widget.selectedValues.isNotEmpty
                      ? widget.selectedValues[0]
                      : null,
                  selectedItemBuilder: (context) {
                    return widget.options!
                        .map((dynamic e) => DropdownMenuItem<dynamic>(
                              child: Container(),
                            ))
                        .toList();
                  },
                  items: widget.options!
                      .map((dynamic x) => DropdownMenuItem<dynamic>(
                            child: _theState.rebuild(() {
                              return _SelectRow(
                                selected: widget.selectedValues.contains(x),
                                child: widget.menuItembuilder != null
                                    ? widget.menuItembuilder!(x)
                                    : Text(
                                        x.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                onChange: (isSelected) {
                                  if (isSelected) {
                                    final ns = widget.selectedValues;
                                    ns.add(x);
                                    widget.onChanged(ns);
                                  } else {
                                    final ns = widget.selectedValues;
                                    ns.remove(x);
                                    widget.onChanged(ns);
                                  }
                                },
                              );
                            }),
                            value: x,
                            onTap: !widget.readOnly
                                ? () {
                                    if (widget.selectedValues.contains(x)) {
                                      final ns = widget.selectedValues;
                                      ns.remove(x);
                                      widget.onChanged(ns);
                                    } else {
                                      final ns = widget.selectedValues;
                                      ns.add(x);
                                      widget.onChanged(ns);
                                    }
                                  }
                                : null,
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
