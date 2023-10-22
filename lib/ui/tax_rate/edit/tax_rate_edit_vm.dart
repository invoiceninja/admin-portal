// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/edit/tax_rate_edit.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/view/tax_rate_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class TaxRateEditScreen extends StatelessWidget {
  const TaxRateEditScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsTaxRatesEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaxRateEditVM>(
      converter: (Store<AppState> store) {
        return TaxRateEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return TaxRateEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.taxRate.updatedAt),
        );
      },
    );
  }
}

class TaxRateEditVM {
  TaxRateEditVM({
    required this.state,
    required this.taxRate,
    required this.company,
    required this.onChanged,
    required this.isSaving,
    required this.origTaxRate,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isLoading,
  });

  factory TaxRateEditVM.fromStore(Store<AppState> store) {
    final taxRate = store.state.taxRateUIState.editing!;
    final state = store.state;

    return TaxRateEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origTaxRate: state.taxRateState.map[taxRate.id],
      taxRate: taxRate,
      company: state.company,
      onChanged: (TaxRateEntity taxRate) {
        store.dispatch(UpdateTaxRate(taxRate));
      },
      onCancelPressed: (context) {
        createEntity(entity: TaxRateEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final taxRate = store.state.taxRateUIState.editing;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          final Completer<TaxRateEntity> completer =
              new Completer<TaxRateEntity>();
          store.dispatch(
              SaveTaxRateRequest(completer: completer, taxRate: taxRate));
          return completer.future.then((savedTaxRate) {
            showToast(taxRate!.isNew
                ? localization!.createdTaxRate
                : localization!.updatedTaxRate);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(TaxRateViewScreen.route));
              if (taxRate.isNew) {
                navigator!.pushReplacementNamed(TaxRateViewScreen.route);
              } else {
                navigator!.pop(savedTaxRate);
              }
            } else {
              viewEntity(entity: savedTaxRate, force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final TaxRateEntity taxRate;
  final CompanyEntity? company;
  final Function(TaxRateEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final TaxRateEntity? origTaxRate;
  final AppState state;
}
