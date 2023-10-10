import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';

class ViewTransactionRuleList implements PersistUI {
  ViewTransactionRuleList({this.force = false});

  final bool force;
}

class ViewTransactionRule implements PersistUI, PersistPrefs {
  ViewTransactionRule({
    required this.transactionRuleId,
    this.force = false,
  });

  final String? transactionRuleId;
  final bool force;
}

class EditTransactionRule implements PersistUI, PersistPrefs {
  EditTransactionRule(
      {required this.transactionRule,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final TransactionRuleEntity transactionRule;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateTransactionRule implements PersistUI {
  UpdateTransactionRule(this.transactionRule);

  final TransactionRuleEntity transactionRule;
}

class LoadTransactionRule {
  LoadTransactionRule({this.completer, this.transactionRuleId});

  final Completer? completer;
  final String? transactionRuleId;
}

class LoadTransactionRuleActivity {
  LoadTransactionRuleActivity({this.completer, this.transactionRuleId});

  final Completer? completer;
  final String? transactionRuleId;
}

class LoadTransactionRules {
  LoadTransactionRules({this.completer});

  final Completer? completer;
}

class LoadTransactionRuleRequest implements StartLoading {}

class LoadTransactionRuleFailure implements StopLoading {
  LoadTransactionRuleFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTransactionRuleFailure{error: $error}';
  }
}

class LoadTransactionRuleSuccess implements StopLoading, PersistData {
  LoadTransactionRuleSuccess(this.transactionRule);

  final TransactionRuleEntity transactionRule;

  @override
  String toString() {
    return 'LoadTransactionRuleSuccess{transactionRule: $transactionRule}';
  }
}

class LoadTransactionRulesRequest implements StartLoading {}

class LoadTransactionRulesFailure implements StopLoading {
  LoadTransactionRulesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTransactionRulesFailure{error: $error}';
  }
}

class LoadTransactionRulesSuccess implements StopLoading {
  LoadTransactionRulesSuccess(this.transactionRules);

  final BuiltList<TransactionRuleEntity> transactionRules;

  @override
  String toString() {
    return 'LoadTransactionRulesSuccess{transactionRules: $transactionRules}';
  }
}

class SaveTransactionRuleRequest implements StartSaving {
  SaveTransactionRuleRequest({this.completer, this.transactionRule});

  final Completer? completer;
  final TransactionRuleEntity? transactionRule;
}

class SaveTransactionRuleSuccess implements StopSaving, PersistData, PersistUI {
  SaveTransactionRuleSuccess(this.transactionRule);

  final TransactionRuleEntity transactionRule;
}

class AddTransactionRuleSuccess implements StopSaving, PersistData, PersistUI {
  AddTransactionRuleSuccess(this.transactionRule);

  final TransactionRuleEntity transactionRule;
}

class SaveTransactionRuleFailure implements StopSaving {
  SaveTransactionRuleFailure(this.error);

  final Object error;
}

class ArchiveTransactionRulesRequest implements StartSaving {
  ArchiveTransactionRulesRequest(this.completer, this.transactionRuleIds);

  final Completer completer;
  final List<String> transactionRuleIds;
}

class ArchiveTransactionRulesSuccess implements StopSaving, PersistData {
  ArchiveTransactionRulesSuccess(this.transactionRules);

  final List<TransactionRuleEntity> transactionRules;
}

class ArchiveTransactionRulesFailure implements StopSaving {
  ArchiveTransactionRulesFailure(this.transactionRules);

  final List<TransactionRuleEntity?> transactionRules;
}

class DeleteTransactionRulesRequest implements StartSaving {
  DeleteTransactionRulesRequest(this.completer, this.transactionRuleIds);

  final Completer completer;
  final List<String> transactionRuleIds;
}

class DeleteTransactionRulesSuccess implements StopSaving, PersistData {
  DeleteTransactionRulesSuccess(this.transactionRules);

  final List<TransactionRuleEntity> transactionRules;
}

class DeleteTransactionRulesFailure implements StopSaving {
  DeleteTransactionRulesFailure(this.transactionRules);

  final List<TransactionRuleEntity?> transactionRules;
}

class RestoreTransactionRulesRequest implements StartSaving {
  RestoreTransactionRulesRequest(this.completer, this.transactionRuleIds);

  final Completer completer;
  final List<String> transactionRuleIds;
}

class RestoreTransactionRulesSuccess implements StopSaving, PersistData {
  RestoreTransactionRulesSuccess(this.transactionRules);

  final List<TransactionRuleEntity> transactionRules;
}

class RestoreTransactionRulesFailure implements StopSaving {
  RestoreTransactionRulesFailure(this.transactionRules);

  final List<TransactionRuleEntity?> transactionRules;
}

class FilterTransactionRules implements PersistUI {
  FilterTransactionRules(this.filter);

  final String? filter;
}

class SortTransactionRules implements PersistUI, PersistPrefs {
  SortTransactionRules(this.field);

  final String field;
}

class FilterTransactionRulesByState implements PersistUI {
  FilterTransactionRulesByState(this.state);

  final EntityState state;
}

class FilterTransactionRulesByCustom1 implements PersistUI {
  FilterTransactionRulesByCustom1(this.value);

  final String value;
}

class FilterTransactionRulesByCustom2 implements PersistUI {
  FilterTransactionRulesByCustom2(this.value);

  final String value;
}

class FilterTransactionRulesByCustom3 implements PersistUI {
  FilterTransactionRulesByCustom3(this.value);

  final String value;
}

class FilterTransactionRulesByCustom4 implements PersistUI {
  FilterTransactionRulesByCustom4(this.value);

  final String value;
}

class StartTransactionRuleMultiselect {
  StartTransactionRuleMultiselect();
}

class AddToTransactionRuleMultiselect {
  AddToTransactionRuleMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromTransactionRuleMultiselect {
  RemoveFromTransactionRuleMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearTransactionRuleMultiselect {
  ClearTransactionRuleMultiselect();
}

class UpdateTransactionRuleTab implements PersistUI {
  UpdateTransactionRuleTab({this.tabIndex});

  final int? tabIndex;
}

void handleTransactionRuleAction(BuildContext? context,
    List<BaseEntity> transactionRules, EntityAction? action) {
  if (transactionRules.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final localization = AppLocalization.of(context);
  final transactionRule = transactionRules.first as TransactionRuleEntity;
  final transactionRuleIds =
      transactionRules.map((transactionRule) => transactionRule.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: transactionRule);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreTransactionRulesRequest(
          snackBarCompleter<Null>(localization!.restoredTransactionRule),
          transactionRuleIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveTransactionRulesRequest(
          snackBarCompleter<Null>(localization!.archivedTransactionRule),
          transactionRuleIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteTransactionRulesRequest(
          snackBarCompleter<Null>(localization!.deletedTransactionRule),
          transactionRuleIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.transactionRuleListState.isInMultiselect()) {
        store.dispatch(StartTransactionRuleMultiselect());
      }

      if (transactionRules.isEmpty) {
        break;
      }

      for (final transactionRule in transactionRules) {
        if (!store.state.transactionRuleListState
            .isSelected(transactionRule.id)) {
          store.dispatch(
              AddToTransactionRuleMultiselect(entity: transactionRule));
        } else {
          store.dispatch(
              RemoveFromTransactionRuleMultiselect(entity: transactionRule));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [transactionRule],
      );
      break;
    default:
      print('## ERROR: unhandled action $action in transaction_rule_actions');
      break;
  }
}
