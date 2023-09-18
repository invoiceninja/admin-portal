// Flutter imports:
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

// Project imports:
//import 'package:invoiceninja_flutter/data/models/entities.dart';
//import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class AppShortcuts extends StatefulWidget {
  const AppShortcuts({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  AppShortcutsState createState() => new AppShortcutsState();

  static AppShortcutsState? of(BuildContext context) {
    return context.findAncestorStateOfType<AppShortcutsState>();
  }
}

class AppShortcutsState extends State<AppShortcuts> {
  /*
  final _shortcuts = <LogicalKeySet, _ShortcutIntent>{
    LogicalKeySet(LogicalKeyboardKey.keyN, LogicalKeyboardKey.keyI):
        _ShortcutIntent.create(EntityType.invoice),
    LogicalKeySet(LogicalKeyboardKey.keyL, LogicalKeyboardKey.keyI):
        _ShortcutIntent.list(EntityType.invoice),
    LogicalKeySet(LogicalKeyboardKey.keyN, LogicalKeyboardKey.keyC):
        _ShortcutIntent.create(EntityType.client),
    LogicalKeySet(LogicalKeyboardKey.keyL, LogicalKeyboardKey.keyC):
        _ShortcutIntent.list(EntityType.client),
    LogicalKeySet(LogicalKeyboardKey.keyN, LogicalKeyboardKey.keyT):
        _ShortcutIntent.create(EntityType.task),
    LogicalKeySet(LogicalKeyboardKey.keyL, LogicalKeyboardKey.keyT):
        _ShortcutIntent.list(EntityType.task),
    LogicalKeySet(LogicalKeyboardKey.keyN, LogicalKeyboardKey.keyE):
        _ShortcutIntent.create(EntityType.expense),
    LogicalKeySet(LogicalKeyboardKey.keyL, LogicalKeyboardKey.keyE):
        _ShortcutIntent.list(EntityType.expense),
    LogicalKeySet(LogicalKeyboardKey.keyN, LogicalKeyboardKey.keyP):
        _ShortcutIntent.create(EntityType.payment),
    LogicalKeySet(LogicalKeyboardKey.keyL, LogicalKeyboardKey.keyP):
        _ShortcutIntent.list(EntityType.payment),
    LogicalKeySet(LogicalKeyboardKey.keyN, LogicalKeyboardKey.keyQ):
        _ShortcutIntent.create(EntityType.quote),
    LogicalKeySet(LogicalKeyboardKey.keyL, LogicalKeyboardKey.keyQ):
        _ShortcutIntent.list(EntityType.quote),
    if (!kIsWeb)
      LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.arrowLeft):
          _ShortcutIntent.back(),
  };
  */

  @override
  Widget build(BuildContext context) {
    return SizedBox();

    /*
    final _actions = <Type, Action<Intent>>{
      _ShortcutIntent: CallbackAction<_ShortcutIntent>(
        onInvoke: (_ShortcutIntent intent) {
          switch (intent.intentType) {
            case _ShortcutIntentType.create:
              createEntityByType(
                  context: context, entityType: intent.entityType);
              break;
            case _ShortcutIntentType.list:
              viewEntitiesByType(entityType: intent.entityType);
              break;
            case _ShortcutIntentType.back:
              Navigator.of(context).maybePop();
              break;
          }

          return null;
        },
      ),
    };

    //return widget.child;

    return Shortcuts(
      shortcuts: _shortcuts,
      child: Actions(
        actions: _actions,
        child: Focus(
          autofocus: true,
          child: widget.child,
        ),
      ),
    );

    return FocusableActionDetector(
      child: widget.child,
      actions: _actions,
      shortcuts: _shortcuts,
      autofocus: false,
    );
    */
  }
}

/*
class _ShortcutIntent extends Intent {
  const _ShortcutIntent({this.intentType, this.entityType});

  const _ShortcutIntent.create(this.entityType)
      : intentType = _ShortcutIntentType.create;

  const _ShortcutIntent.list(this.entityType)
      : intentType = _ShortcutIntentType.list;

  const _ShortcutIntent.back()
      : intentType = _ShortcutIntentType.back,
        entityType = null;

  final _ShortcutIntentType intentType;
  final EntityType entityType;
}

enum _ShortcutIntentType {
  create,
  back,
  list,
}

*/
