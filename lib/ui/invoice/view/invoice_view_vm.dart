import 'dart:async';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceViewScreen extends StatelessWidget {
  const InvoiceViewScreen({Key key}) : super(key: key);

  static const String route = '/invoice/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceViewVM>(
      distinct: true,
      converter: (Store<AppState> store) {
        return InvoiceViewVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceView(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityViewVM {
  EntityViewVM({
    @required this.company,
    @required this.invoice,
    @required this.client,
    @required this.isSaving,
    @required this.isDirty,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onClientPressed,
    @required this.onPaymentsPressed,
    @required this.onPaymentPressed,
    @required this.onRefreshed,
  });

  final CompanyEntity company;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final bool isSaving;
  final bool isDirty;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext, [InvoiceItemEntity]) onEditPressed;
  final Function(BuildContext, [bool]) onClientPressed;
  final Function(BuildContext) onPaymentsPressed;
  final Function(BuildContext, PaymentEntity, [bool]) onPaymentPressed;
  final Function(BuildContext) onRefreshed;
  final Function onBackPressed;

  @override
  bool operator ==(dynamic other) =>
      client == other.client &&
      company == other.company &&
      invoice == other.invoice &&
      isSaving == other.isSaving &&
      isDirty == other.isDirty;

  @override
  int get hashCode =>
      client.hashCode ^
      company.hashCode ^
      invoice.hashCode ^
      isSaving.hashCode ^
      isDirty.hashCode;
}

class InvoiceViewVM extends EntityViewVM {
  InvoiceViewVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    ClientEntity client,
    bool isSaving,
    bool isDirty,
    Function(BuildContext, EntityAction) onActionSelected,
    Function(BuildContext, [InvoiceItemEntity]) onEditPressed,
    Function(BuildContext, [bool]) onClientPressed,
    Function(BuildContext, PaymentEntity, [bool]) onPaymentPressed,
    Function(BuildContext) onPaymentsPressed,
    Function(BuildContext) onRefreshed,
    Function onBackPressed,
  }) : super(
          company: company,
          invoice: invoice,
          client: client,
          isSaving: isSaving,
          isDirty: isDirty,
          onActionSelected: onActionSelected,
          onEditPressed: onEditPressed,
          onClientPressed: onClientPressed,
          onPaymentPressed: onPaymentPressed,
          onPaymentsPressed: onPaymentsPressed,
          onRefreshed: onRefreshed,
          onBackPressed: onBackPressed,
        );

  factory InvoiceViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoice = state.invoiceState.map[state.invoiceUIState.selectedId] ??
        InvoiceEntity(id: state.invoiceUIState.selectedId);
    final client = store.state.clientState.map[invoice.clientId] ??
        ClientEntity(id: invoice.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadInvoice(completer: completer, invoiceId: invoice.id));
      return completer.future;
    }

    return InvoiceViewVM(
        company: state.selectedCompany,
        isSaving: state.isSaving,
        isDirty: invoice.isNew,
        invoice: invoice,
        client: client,
        onEditPressed: (BuildContext context, [InvoiceItemEntity invoiceItem]) {
          final Completer<InvoiceEntity> completer =
              new Completer<InvoiceEntity>();
          store.dispatch(EditInvoice(
              invoice: invoice,
              context: context,
              completer: completer,
              invoiceItem: invoiceItem));
          completer.future.then((invoice) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
              message: AppLocalization.of(context).updatedInvoice,
            )));
          });
        },
        onRefreshed: (context) => _handleRefresh(context),
        onBackPressed: () {
          if (state.uiState.currentRoute.contains(InvoiceScreen.route)) {
            store.dispatch(UpdateCurrentRoute(InvoiceScreen.route));
          }
        },
        onClientPressed: (BuildContext context, [bool longPress = false]) =>
            store.dispatch(longPress
                ? EditClient(client: client, context: context)
                : ViewClient(clientId: client.id, context: context)),
        onPaymentPressed: (BuildContext context, PaymentEntity payment,
                [bool longPress = false]) =>
            store.dispatch(longPress
                ? EditPayment(payment: payment, context: context)
                : ViewPayment(paymentId: payment.id, context: context)),
        onPaymentsPressed: (BuildContext context) {
          store.dispatch(FilterPaymentsByEntity(
              entityId: invoice.id, entityType: EntityType.invoice));
          store.dispatch(ViewPaymentList(context));
        },
        onActionSelected: (BuildContext context, EntityAction action) async {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.pdf:
              viewPdf(invoice, context);
              break;
            case EntityAction.clientPortal:
              if (await canLaunch(invoice.invitationSilentLink)) {
                await launch(invoice.invitationSilentLink,
                    forceSafariVC: false, forceWebView: false);
              }
              break;
            case EntityAction.markSent:
              store.dispatch(MarkSentInvoiceRequest(
                  snackBarCompleter(context, localization.markedInvoiceAsSent),
                  invoice.id));
              break;
            case EntityAction.sendEmail:
              store.dispatch(ShowEmailInvoice(
                  completer:
                      snackBarCompleter(context, localization.emailedInvoice),
                  invoice: invoice,
                  context: context));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveInvoiceRequest(
                  popCompleter(context, localization.archivedInvoice),
                  invoice.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteInvoiceRequest(
                  popCompleter(context, localization.deletedInvoice),
                  invoice.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreInvoiceRequest(
                  snackBarCompleter(context, localization.restoredInvoice),
                  invoice.id));
              break;
            case EntityAction.cloneToInvoice:
              Navigator.of(context).pop();
              store.dispatch(EditInvoice(
                  context: context, invoice: invoice.cloneToInvoice));
              break;
            case EntityAction.cloneToQuote:
              Navigator.of(context).pop();
              store.dispatch(
                  EditQuote(context: context, quote: invoice.cloneToQuote));
              break;
            case EntityAction.enterPayment:
              store.dispatch(EditPayment(
                  context: context,
                  payment: invoice.createPayment(state.selectedCompany)));
              break;
          }
        });
  }
}
