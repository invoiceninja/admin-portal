// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentViewScreen extends StatelessWidget {
  const PaymentViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/payment/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentViewVM>(
      converter: (Store<AppState> store) {
        return PaymentViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return PaymentView(
          viewModel: vm,
          isFilter: isFilter,
          tabIndex: vm.state.paymentUIState.tabIndex,
        );
      },
    );
  }
}

class PaymentViewVM {
  PaymentViewVM({
    required this.state,
    required this.payment,
    required this.company,
    required this.onEntityAction,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
    required this.onUploadDocuments,
  });

  factory PaymentViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final payment = state.paymentState.map[state.paymentUIState.selectedId] ??
        PaymentEntity(id: state.paymentUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadPayment(
        completer: completer,
        paymentId: payment.id,
      ));
      return completer.future;
    }

    return PaymentViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: payment.isNew,
      isLoading: state.isLoading,
      payment: payment,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([payment], action, autoPop: true),
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFile, bool isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SavePaymentDocumentRequest(
          isPrivate: isPrivate,
          multipartFiles: multipartFile,
          payment: payment,
          completer: completer,
        ));
        completer.future.then((client) {
          showToast(AppLocalization.of(context)!.uploadedDocument);
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

  final AppState state;
  final PaymentEntity payment;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<MultipartFile>, bool) onUploadDocuments;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
