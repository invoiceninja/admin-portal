import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CreditEditScreen extends StatelessWidget {
  const CreditEditScreen({Key key}) : super(key: key);
  static const String route = '/credit/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditEditVM>(
      converter: (Store<AppState> store) {
        return CreditEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return CreditEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.credit.id),
        );
      },
    );
  }
}

class CreditEditVM {
  CreditEditVM({
    @required this.state,
    @required this.credit,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origCredit,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
  });

  factory CreditEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final credit = state.creditUIState.editing;

    return CreditEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origCredit: state.creditState.map[credit.id],
      credit: credit,
      company: state.selectedCompany,
      onChanged: (InvoiceEntity credit) {
        store.dispatch(UpdateCredit(credit));
      },
      onCancelPressed: (BuildContext context) {
        store.dispatch(
            EditCredit(credit: InvoiceEntity(), context: context, force: true));
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        final Completer<InvoiceEntity> completer = new Completer<InvoiceEntity>();
        store.dispatch(SaveCreditRequest(completer: completer, credit: credit));
        return completer.future.then((savedCredit) {
          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(CreditViewScreen.route));
            if (credit.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(CreditViewScreen.route);
            } else {
              Navigator.of(context).pop(savedCredit);
            }
          } else {
            store.dispatch(ViewCredit(
                context: context, creditId: savedCredit.id, force: true));
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final InvoiceEntity credit;
  final CompanyEntity company;
  final Function(InvoiceEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final InvoiceEntity origCredit;
  final AppState state;
}
