// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class EntityDropdown extends StatefulWidget {
  const EntityDropdown({
    required this.entityType,
    required this.labelText,
    required this.onSelected,
    this.entityMap,
    this.entityList,
    this.allowClearing = true,
    this.autoValidate = false,
    this.validator,
    this.entityId,
    this.onAddPressed,
    this.autofocus = false,
    this.onFieldSubmitted,
    this.overrideSuggestedAmount,
    this.overrideSuggestedLabel,
    this.onCreateNew,
    this.excludeIds = const [],
  });

  final EntityType? entityType;
  final List<String?>? entityList;
  final String? labelText;
  final String? entityId;
  final bool? autofocus;
  final BuiltMap<String?, SelectableEntity?>? entityMap;
  final Function(SelectableEntity?) onSelected;
  final String? Function(String?)? validator;
  final bool autoValidate;
  final bool allowClearing;
  final Function(String?)? onFieldSubmitted;
  final Function(Completer<SelectableEntity> completer)? onAddPressed;
  final Function(SelectableEntity)? overrideSuggestedAmount;
  final Function(SelectableEntity?)? overrideSuggestedLabel;
  final Function(Completer<SelectableEntity> completer, String)? onCreateNew;
  final List<String> excludeIds;

  @override
  _EntityDropdownState createState() => _EntityDropdownState();
}

class _EntityDropdownState extends State<EntityDropdown> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  String _filter = '';
  BuiltMap<String?, SelectableEntity?>? _entityMap;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus && isMobile(context)) {
      _showOptions();
    }

    if (!_focusNode.hasFocus && !hasValue) {
      _textController.text = '';
    }
  }

  String? _getEntityLabel(SelectableEntity? entity) {
    if (entity == null) {
      return '';
    }

    var value = entity.listDisplayName;

    if (!(entity is BaseEntity)) {
      return value;
    }

    if (entity.isDeleted!) {
      value = value + ' - ' + AppLocalization.of(context)!.deleted;
    }

    return value;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.entityId != oldWidget.entityId) {
      final state = StoreProvider.of<AppState>(context).state;
      _entityMap = widget.entityMap ?? state.getEntityMap(widget.entityType);
      _textController.text = _getEntityLabel(_entityMap![widget.entityId])!;
    }
  }

  @override
  void didChangeDependencies() {
    final state = StoreProvider.of<AppState>(context).state;
    _entityMap = widget.entityMap ?? state.getEntityMap(widget.entityType);

    if (_entityMap == null) {
      print('## ERROR: ENTITY MAP IS NULL: ${widget.entityType}');
    } else {
      final entity = _entityMap![widget.entityId];
      if (widget.overrideSuggestedLabel != null) {
        _textController.text = widget.overrideSuggestedLabel!(entity);
      } else if (entity == null) {
        // do nothing
      } else {
        _textController.text = _getEntityLabel(entity)!;
      }
    }

    super.didChangeDependencies();
  }

/*
  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entityId == widget.entityId) {
      return;
    }

    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    _entityMap = widget.entityMap ?? state.getEntityMap(widget.entityType);

    if (_entityMap == null) {
      print('## ERROR: ENTITY MAP IS NULL: ${widget.entityType}');
    } else {
      final entity = _entityMap[widget.entityId];
      if (widget.overrideSuggestedLabel != null) {
        _textController.text = widget.overrideSuggestedLabel(entity);
      } else {
        _textController.text = entity?.listDisplayName ??
            (widget.showUseDefault ? localization.useDefault : '');
      }
    }
  }
  */

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _showOptions() {
    showDialog<EntityDropdownDialog>(
        context: context,
        builder: (BuildContext context) {
          return EntityDropdownDialog(
            entityMap: _entityMap,
            entityList: (widget.entityList ?? _entityMap!.keys)
                .where((elementId) => !widget.excludeIds.contains(elementId))
                .toList(),
            onSelected: (entity, [update = true]) {
              if (entity.id == widget.entityId) {
                return;
              }

              widget.onSelected(entity);

              final String? label = widget.overrideSuggestedLabel != null
                  ? widget.overrideSuggestedLabel!(entity)
                  : entity.listDisplayName;

              if (update) {
                _textController.text = label!;
              }

              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(label);
              }
            },
            onAddPressed: widget.onAddPressed != null
                ? (context, completer) => widget
                    .onAddPressed!(completer as Completer<SelectableEntity>)
                : null,
            overrideSuggestedAmount: widget.overrideSuggestedAmount,
            overrideSuggestedLabel: widget.overrideSuggestedLabel,
          );
        });
  }

  bool get hasValue =>
      widget.entityId != null &&
      widget.entityId != '0' &&
      widget.entityId!.isNotEmpty;

  bool get showClear => widget.allowClearing && hasValue;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    if (!state.company.isModuleEnabled(widget.entityType)) {
      return SizedBox();
    }

    final theme = Theme.of(context);
    final iconButton = showClear
        ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _textController.text = '';
              widget.onSelected(null);
            },
          )
        : widget.onAddPressed != null
            ? IconButton(
                icon: Icon(Icons.add_circle_outline),
                tooltip: AppLocalization.of(context)!.createNew,
                onPressed: () {
                  final Completer<SelectableEntity> completer =
                      Completer<SelectableEntity>();
                  widget.onAddPressed!(completer);
                  completer.future.then(
                    (entity) {
                      widget.onSelected(entity);
                    },
                  );
                },
              )
            : null;

    // TODO remove DEMO_MODE check
    if (isNotMobile(context) && !Config.DEMO_MODE) {
      return RawAutocomplete<SelectableEntity>(
        focusNode: _focusNode,
        textEditingController: _textController,
        optionsBuilder: (TextEditingValue textEditingValue) {
          final options = (widget.entityList ?? widget.entityMap!.keys.toList())
              .map((entityId) => _entityMap![entityId])
              .whereType<SelectableEntity>()
              .where((entity) => entity.matchesFilter(textEditingValue.text))
              .where((element) => !widget.excludeIds.contains(element.id))
              .toList();

          if (options.length == 1 && options[0].id == widget.entityId) {
            return <SelectableEntity>[];
          }

          if (widget.onCreateNew != null &&
              options.isEmpty &&
              _filter.trim().isNotEmpty &&
              textEditingValue.text.trim().isNotEmpty &&
              state.userCompany.canCreate(widget.entityType)) {
            options.add(_AutocompleteEntity(name: textEditingValue.text));
          }

          return options;
        },
        displayStringForOption: (entity) => entity.listDisplayName,
        onSelected: (entity) {
          _filter = '';
          /*
          _textController.text = widget.overrideSuggestedLabel != null
              ? widget.overrideSuggestedLabel(entity)
              : entity?.listDisplayName;
              */

          if (entity.id == widget.entityId) {
            return;
          }

          void _wrapUp(SelectableEntity entity) {
            widget.onSelected(entity);
            _focusNode.requestFocus();

            WidgetsBinding.instance.addPostFrameCallback((duration) {
              _textController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _textController.text.length));
            });
          }

          if (entity.id == _AutocompleteEntity.KEY) {
            final name = (entity as _AutocompleteEntity).name!.trim();
            _textController.text = name;

            _focusNode.removeListener(_onFocusChanged);
            _focusNode.requestFocus();
            WidgetsBinding.instance.addPostFrameCallback((duration) {
              _textController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _textController.text.length));
            });

            final completer = Completer<SelectableEntity>();
            completer.future.then((value) {
              showToast(AppLocalization.of(navigatorKey.currentContext!)!
                  .createdRecord);
              _wrapUp(value);
              _focusNode.addListener(_onFocusChanged);
            }).catchError((dynamic error) {
              _focusNode.addListener(_onFocusChanged);
            });
            widget.onCreateNew!(completer, name);
          } else {
            _wrapUp(entity);
          }
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return DecoratedFormField(
            validator: widget.validator,
            showClear: showClear,
            label: widget.labelText,
            autofocus:
                (widget.autofocus ?? false) && (widget.entityId ?? '').isEmpty,
            controller: textEditingController,
            focusNode: focusNode,
            keyboardType: TextInputType.text,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
            onChanged: (value) {
              _filter = value;
              if (hasValue) {
                widget.onSelected(null);
              }
            },
            suffixIconButton: iconButton,
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<SelectableEntity> onSelected,
            Iterable<SelectableEntity> options) {
          if (hasValue) {
            return SizedBox();
          }

          return Theme(
            data: theme,
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                child: AppBorder(
                  child: Container(
                    color: Theme.of(context).cardColor,
                    width: 250,
                    constraints: BoxConstraints(maxHeight: 270),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: ScrollableListViewBuilder(
                        scrollController: _scrollController,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Builder(builder: (BuildContext context) {
                            final highlightedIndex =
                                AutocompleteHighlightedOption.of(context);
                            if (highlightedIndex == index) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Scrollable.ensureVisible(context);
                              });
                            }
                            return Container(
                              color: highlightedIndex == index
                                  ? convertHexStringToColor(
                                      state.prefState.enableDarkMode
                                          ? kDefaultDarkSelectedColor
                                          : kDefaultLightSelectedColor)
                                  : Theme.of(context).cardColor,
                              child: EntityAutocompleteListTile(
                                onTap: (entity) => onSelected(entity),
                                entity: options.elementAt(index),
                                filter: _filter,
                                overrideSuggestedAmount:
                                    widget.overrideSuggestedAmount,
                                overrideSuggestedLabel:
                                    widget.overrideSuggestedLabel,
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        InkWell(
          onTap: () => _showOptions(),
          child: IgnorePointer(
            child: TextFormField(
              focusNode: _focusNode,
              readOnly: true,
              validator: widget.validator,
              autovalidateMode: widget.autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction,
              controller: _textController,
              decoration: InputDecoration(
                labelText: widget.labelText,
                suffixIcon: showClear ? null : const Icon(Icons.search),
              ),
            ),
          ),
        ),
        if (showClear)
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _textController.text = '';
              widget.onSelected(null);
            },
          ),
      ],
    );
  }
}

class EntityDropdownDialog extends StatefulWidget {
  const EntityDropdownDialog({
    required this.entityMap,
    required this.entityList,
    required this.onSelected,
    required this.overrideSuggestedLabel,
    required this.overrideSuggestedAmount,
    this.onAddPressed,
    this.excludeIds = const [],
  });

  final BuiltMap<String?, SelectableEntity?>? entityMap;
  final List<String?> entityList;
  final Function(SelectableEntity, [bool]) onSelected;
  final Function(BuildContext context, Completer completer)? onAddPressed;
  final Function(SelectableEntity)? overrideSuggestedAmount;
  final Function(SelectableEntity)? overrideSuggestedLabel;
  final List<String> excludeIds;

  @override
  _EntityDropdownDialogState createState() => _EntityDropdownDialogState();
}

class _EntityDropdownDialogState extends State<EntityDropdownDialog> {
  String? _filter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    void _selectEntity(SelectableEntity entity) {
      widget.onSelected(entity);
      Navigator.pop(context);
    }

    Widget _headerRow() {
      return Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: TextField(
              /*
              onSubmitted: (value) {
                final entityId = widget.entityList.firstWhere((entityId) =>
                    _entityMap[entityId].matchesFilter(_filter));
                final entity = _entityMap[entityId];
                _selectEntity(entity);
              },
               */
              onChanged: (value) {
                setState(() {
                  _filter = value;
                });
              },
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: localization!.filter,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          widget.onAddPressed != null
              ? IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  tooltip: localization.createNew,
                  onPressed: () {
                    Navigator.pop(context);
                    final Completer<SelectableEntity> completer =
                        Completer<SelectableEntity>();
                    widget.onAddPressed!(context, completer);
                    completer.future.then((entity) {
                      widget.onSelected(entity, false);
                    });
                  },
                )
              : Container()
        ],
      );
    }

    Widget _createList() {
      final matches = widget.entityList
          .where((entityId) =>
              widget.entityMap![entityId]?.matchesFilter(_filter) ?? false)
          .where((entityId) => !widget.excludeIds.contains(entityId))
          .toList();

      return ScrollableListViewBuilder(
        itemCount: matches.length,
        itemBuilder: (BuildContext context, int index) {
          final entityId = matches[index];
          final entity = widget.entityMap![entityId]!;
          return EntityAutocompleteListTile(
            entity: entity,
            filter: _filter,
            onTap: (entity) => _selectEntity(entity),
            overrideSuggestedAmount: widget.overrideSuggestedAmount,
            overrideSuggestedLabel: widget.overrideSuggestedLabel,
          );
        },
      );
    }

    return ResponsivePadding(
      child: Material(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _headerRow(),
            Expanded(child: _createList()),
          ],
        ),
      ),
    );
  }
}

class EntityAutocompleteListTile extends StatelessWidget {
  const EntityAutocompleteListTile(
      {required this.entity,
      this.filter,
      this.overrideSuggestedLabel,
      this.overrideSuggestedAmount,
      this.onTap,
      this.subtitle});

  final SelectableEntity entity;
  final Function(SelectableEntity entity)? onTap;
  final String? filter;
  final String? subtitle;
  final Function(SelectableEntity)? overrideSuggestedAmount;
  final Function(SelectableEntity)? overrideSuggestedLabel;

  @override
  Widget build(BuildContext context) {
    final String? subtitle = this.subtitle ?? entity.matchesFilterValue(filter);
    final String label = overrideSuggestedLabel == null
        ? entity.listDisplayName
        : overrideSuggestedLabel!(entity);
    final String? amount = overrideSuggestedAmount == null
        ? formatNumber(entity.listDisplayAmount, context,
            formatNumberType: entity.listDisplayAmountType)
        : overrideSuggestedAmount!(entity);

    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (entity.id == _AutocompleteEntity.KEY)
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 4),
              child: Icon(
                Icons.add_circle_outline,
                size: 16,
              ),
            ),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.titleMedium),
          ),
          entity.listDisplayAmount != null
              ? Text(amount!, style: Theme.of(context).textTheme.titleMedium)
              : Container(),
        ],
      ),
      subtitle:
          (subtitle ?? '').isNotEmpty ? Text(subtitle!, maxLines: 2) : null,
      onTap: onTap != null ? () => onTap!(entity) : null,
    );
  }
}

class _AutocompleteEntity extends Object with SelectableEntity {
  _AutocompleteEntity({this.name});

  static const KEY = '__new__';

  final String? name;

  @override
  String get id => KEY;

  @override
  bool matchesFilter(String? filter) => true;

  @override
  String? matchesFilterValue(String? filter) => null;

  @override
  String get listDisplayName {
    final localization = AppLocalization.of(navigatorKey.currentContext!)!;
    return '${localization.create}: $name';
  }

  @override
  double? get listDisplayAmount => null;
}
