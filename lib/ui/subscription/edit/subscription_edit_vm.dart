import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/subscription/view/subscription_view_vm.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';
import 'package:invoiceninja_flutter/data/models/subscription_model.dart';
import 'package:invoiceninja_flutter/ui/subscription/edit/subscription_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class SubscriptionEditScreen extends StatelessWidget {
  const SubscriptionEditScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsSubscriptionsEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SubscriptionEditVM>(
      converter: (Store<AppState> store) {
        return SubscriptionEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return SubscriptionEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.subscription.id),
        );
      },
    );
  }
}

class SubscriptionEditVM {
  SubscriptionEditVM({
    @required this.state,
    @required this.subscription,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origSubscription,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
  });

  factory SubscriptionEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final subscription = state.subscriptionUIState.editing;

    return SubscriptionEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origSubscription: state.subscriptionState.map[subscription.id],
      subscription: subscription,
      company: state.company,
      onChanged: (SubscriptionEntity subscription) {
        store.dispatch(UpdateSubscription(subscription));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(
            context: context, entity: SubscriptionEntity(), force: true);
        if (state.subscriptionUIState.cancelCompleter != null) {
          state.subscriptionUIState.cancelCompleter.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onSavePressed: (BuildContext context) {
        final appContext = context.getAppContext();
        Debouncer.runOnComplete(() {
          final subscription = store.state.subscriptionUIState.editing;
          if (subscription.name.isEmpty) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext,
                builder: (BuildContext context) {
                  return ErrorDialog(appContext.localization.pleaseEnterAName);
                });
            return null;
          }

          final localization = appContext.localization;
          final Completer<SubscriptionEntity> completer =
              new Completer<SubscriptionEntity>();
          store.dispatch(SaveSubscriptionRequest(
              completer: completer, subscription: subscription));
          return completer.future.then((savedSubscription) {
            showToast(subscription.isNew
                ? localization.createdSubscription
                : localization.updatedSubscription);
            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(SubscriptionViewScreen.route));
              if (subscription.isNew) {
                appContext.navigator
                    .pushReplacementNamed(SubscriptionViewScreen.route);
              } else {
                appContext.navigator.pop(savedSubscription);
              }
            } else {
              viewEntity(
                  appContext: appContext,
                  entity: savedSubscription,
                  force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final SubscriptionEntity subscription;
  final CompanyEntity company;
  final Function(SubscriptionEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final SubscriptionEntity origSubscription;
  final AppState state;
}
