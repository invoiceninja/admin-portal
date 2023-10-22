// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_email_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class InvoiceEmailScreen extends StatelessWidget {
  const InvoiceEmailScreen({Key? key}) : super(key: key);

  static const String route = '/invoice/email';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailInvoiceVM>(
      onInit: (Store<AppState> store) {
        final state = store.state;
        final invoiceId = state.uiState.invoiceUIState.selectedId!;
        final invoice = state.invoiceState.get(invoiceId);
        final client = state.clientState.get(invoice.clientId);
        if (client.isStale) {
          store.dispatch(LoadClient(clientId: client.id));
        }
      },
      converter: (Store<AppState> store) {
        final state = store.state;
        final invoiceId = state.uiState.invoiceUIState.selectedId!;
        final invoice = state.invoiceState.get(invoiceId);
        return EmailInvoiceVM.fromStore(store, invoice);
      },
      builder: (context, vm) {
        return InvoiceEmailView(
          key: ValueKey('__invoice_${vm.invoice!.id}__'),
          viewModel: vm,
        );
      },
    );
  }
}

abstract class EmailEntityVM {
  EmailEntityVM({
    required this.state,
    required this.isLoading,
    required this.isSaving,
    required this.company,
    required this.invoice,
    required this.client,
    required this.vendor,
    required this.onSendPressed,
  });

  final AppState? state;
  final bool? isLoading;
  final bool? isSaving;
  final CompanyEntity? company;
  final InvoiceEntity? invoice;
  final ClientEntity? client;
  final VendorEntity? vendor;
  final Function(BuildContext, EmailTemplate, String, String, String)?
      onSendPressed;
}

class EmailInvoiceVM extends EmailEntityVM {
  EmailInvoiceVM({
    AppState? state,
    bool? isLoading,
    bool? isSaving,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    ClientEntity? client,
    VendorEntity? vendor,
    Function(BuildContext, EmailTemplate, String, String, String)?
        onSendPressed,
  }) : super(
          state: state,
          isLoading: isLoading,
          isSaving: isSaving,
          company: company,
          invoice: invoice,
          client: client,
          vendor: vendor,
          onSendPressed: onSendPressed,
        );

  factory EmailInvoiceVM.fromStore(
      Store<AppState> store, InvoiceEntity invoice) {
    final state = store.state;

    return EmailInvoiceVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      company: state.company,
      invoice: invoice,
      client: state.clientState.map[invoice.clientId] ??
          ClientEntity(id: invoice.clientId),
      onSendPressed: (context, template, subject, body, ccEmail) {
        final completer = snackBarCompleter<Null>(
            AppLocalization.of(context)!.emailedInvoice,
            shouldPop: isMobile(context));
        if (!isMobile(context)) {
          completer.future.then<Null>((_) {
            viewEntity(entity: invoice);
          });
        }
        store.dispatch(EmailInvoiceRequest(
          completer: completer,
          invoiceId: invoice.id,
          template: template,
          subject: subject,
          body: body,
          ccEmail: ccEmail,
        ));
      },
    );
  }
}
