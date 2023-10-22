// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewSubscriptionList implements PersistUI {
  ViewSubscriptionList({
    this.force = false,
  });

  final bool force;
}

class ViewSubscription implements PersistUI, PersistPrefs {
  ViewSubscription({
    required this.subscriptionId,
    this.force = false,
  });

  final String? subscriptionId;
  final bool force;
}

class EditSubscription implements PersistUI, PersistPrefs {
  EditSubscription(
      {required this.subscription,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final SubscriptionEntity subscription;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateSubscription implements PersistUI {
  UpdateSubscription(this.subscription);

  final SubscriptionEntity subscription;
}

class LoadSubscription {
  LoadSubscription({this.completer, this.subscriptionId});

  final Completer? completer;
  final String? subscriptionId;
}

class LoadSubscriptionActivity {
  LoadSubscriptionActivity({this.completer, this.subscriptionId});

  final Completer? completer;
  final String? subscriptionId;
}

class LoadSubscriptions {
  LoadSubscriptions({this.completer});

  final Completer? completer;
}

class LoadSubscriptionRequest implements StartLoading {}

class LoadSubscriptionFailure implements StopLoading {
  LoadSubscriptionFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadSubscriptionFailure{error: $error}';
  }
}

class LoadSubscriptionSuccess implements StopLoading, PersistData {
  LoadSubscriptionSuccess(this.subscription);

  final SubscriptionEntity subscription;

  @override
  String toString() {
    return 'LoadSubscriptionSuccess{subscription: $subscription}';
  }
}

class LoadSubscriptionsRequest implements StartLoading {}

class LoadSubscriptionsFailure implements StopLoading {
  LoadSubscriptionsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadSubscriptionsFailure{error: $error}';
  }
}

class LoadSubscriptionsSuccess implements StopLoading {
  LoadSubscriptionsSuccess(this.subscriptions);

  final BuiltList<SubscriptionEntity> subscriptions;

  @override
  String toString() {
    return 'LoadSubscriptionsSuccess{subscriptions: $subscriptions}';
  }
}

class SaveSubscriptionRequest implements StartSaving {
  SaveSubscriptionRequest({this.completer, this.subscription});

  final Completer? completer;
  final SubscriptionEntity? subscription;
}

class SaveSubscriptionSuccess implements StopSaving, PersistData, PersistUI {
  SaveSubscriptionSuccess(this.subscription);

  final SubscriptionEntity subscription;
}

class AddSubscriptionSuccess implements StopSaving, PersistData, PersistUI {
  AddSubscriptionSuccess(this.subscription);

  final SubscriptionEntity subscription;
}

class SaveSubscriptionFailure implements StopSaving {
  SaveSubscriptionFailure(this.error);

  final Object error;
}

class ArchiveSubscriptionsRequest implements StartSaving {
  ArchiveSubscriptionsRequest(this.completer, this.subscriptionIds);

  final Completer completer;
  final List<String> subscriptionIds;
}

class ArchiveSubscriptionsSuccess implements StopSaving, PersistData {
  ArchiveSubscriptionsSuccess(this.subscriptions);

  final List<SubscriptionEntity> subscriptions;
}

class ArchiveSubscriptionsFailure implements StopSaving {
  ArchiveSubscriptionsFailure(this.subscriptions);

  final List<SubscriptionEntity?> subscriptions;
}

class DeleteSubscriptionsRequest implements StartSaving {
  DeleteSubscriptionsRequest(this.completer, this.subscriptionIds);

  final Completer completer;
  final List<String> subscriptionIds;
}

class DeleteSubscriptionsSuccess implements StopSaving, PersistData {
  DeleteSubscriptionsSuccess(this.subscriptions);

  final List<SubscriptionEntity> subscriptions;
}

class DeleteSubscriptionsFailure implements StopSaving {
  DeleteSubscriptionsFailure(this.subscriptions);

  final List<SubscriptionEntity?> subscriptions;
}

class RestoreSubscriptionsRequest implements StartSaving {
  RestoreSubscriptionsRequest(this.completer, this.subscriptionIds);

  final Completer completer;
  final List<String> subscriptionIds;
}

class RestoreSubscriptionsSuccess implements StopSaving, PersistData {
  RestoreSubscriptionsSuccess(this.subscriptions);

  final List<SubscriptionEntity> subscriptions;
}

class RestoreSubscriptionsFailure implements StopSaving {
  RestoreSubscriptionsFailure(this.subscriptions);

  final List<SubscriptionEntity?> subscriptions;
}

class FilterSubscriptions implements PersistUI {
  FilterSubscriptions(this.filter);

  final String? filter;
}

class SortSubscriptions implements PersistUI, PersistPrefs {
  SortSubscriptions(this.field);

  final String field;
}

class FilterSubscriptionsByState implements PersistUI {
  FilterSubscriptionsByState(this.state);

  final EntityState state;
}

class FilterSubscriptionsByCustom1 implements PersistUI {
  FilterSubscriptionsByCustom1(this.value);

  final String value;
}

class FilterSubscriptionsByCustom2 implements PersistUI {
  FilterSubscriptionsByCustom2(this.value);

  final String value;
}

class FilterSubscriptionsByCustom3 implements PersistUI {
  FilterSubscriptionsByCustom3(this.value);

  final String value;
}

class FilterSubscriptionsByCustom4 implements PersistUI {
  FilterSubscriptionsByCustom4(this.value);

  final String value;
}

class StartSubscriptionMultiselect {
  StartSubscriptionMultiselect();
}

class AddToSubscriptionMultiselect {
  AddToSubscriptionMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromSubscriptionMultiselect {
  RemoveFromSubscriptionMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearSubscriptionMultiselect {
  ClearSubscriptionMultiselect();
}

class UpdateSubscriptionTab implements PersistUI {
  UpdateSubscriptionTab({this.tabIndex});

  final int? tabIndex;
}

void handleSubscriptionAction(BuildContext? context,
    List<BaseEntity> subscriptions, EntityAction? action) {
  if (subscriptions.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final localization = AppLocalization.of(context);
  final subscription = subscriptions.first as SubscriptionEntity;
  final subscriptionIds =
      subscriptions.map((subscription) => subscription.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: subscription);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreSubscriptionsRequest(
          snackBarCompleter<Null>(localization!.restoredPaymentLink),
          subscriptionIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveSubscriptionsRequest(
          snackBarCompleter<Null>(localization!.archivedPaymentLink),
          subscriptionIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteSubscriptionsRequest(
          snackBarCompleter<Null>(localization!.deletedPaymentLink),
          subscriptionIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.subscriptionListState.isInMultiselect()) {
        store.dispatch(StartSubscriptionMultiselect());
      }

      if (subscriptions.isEmpty) {
        break;
      }

      for (final subscription in subscriptions) {
        if (!store.state.subscriptionListState.isSelected(subscription.id)) {
          store.dispatch(AddToSubscriptionMultiselect(entity: subscription));
        } else {
          store.dispatch(
              RemoveFromSubscriptionMultiselect(entity: subscription));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [subscription],
      );
      break;
    default:
      print('## ERROR: unhandled action $action in subscription_actions');
      break;
  }
}
