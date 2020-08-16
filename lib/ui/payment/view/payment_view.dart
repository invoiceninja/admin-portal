import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final PaymentViewVM viewModel;
  final bool isFilter;

  @override
  _PaymentViewState createState() => new _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final payment = viewModel.payment;
    final state = StoreProvider.of<AppState>(context).state;
    final client = state.clientState.map[payment.clientId] ??
        ClientEntity(id: payment.clientId);
    final localization = AppLocalization.of(context);

    final fields = <String, String>{};
    /*
    fields[PaymentFields.paymentStatusId] =
        localization.lookup('payment_status_${payment.statusId}');
     */
    if (payment.date.isNotEmpty) {
      fields[PaymentFields.paymentDate] = formatDate(payment.date, context);
    }
    if ((payment.typeId ?? '').isNotEmpty) {
      final paymentType = state.staticState.paymentTypeMap[payment.typeId];
      if (paymentType != null) {
        fields[PaymentFields.paymentTypeId] = paymentType.name;
      }
    }
    if (payment.transactionReference.isNotEmpty) {
      fields[PaymentFields.transactionReference] = payment.transactionReference;
    }
    if (payment.refunded != 0) {
      fields[PaymentFields.refunded] =
          formatNumber(payment.refunded, context, clientId: client.id);
    }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: payment,
      title: payment.number,
      body: Builder(
        builder: (BuildContext context) {
          return RefreshIndicator(
            onRefresh: () => viewModel.onRefreshed(context),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      EntityHeader(
                        entity: payment,
                        statusColor:
                            PaymentStatusColors.colors[payment.statusId],
                        statusLabel: localization
                            .lookup('payment_status_${payment.statusId}'),
                        label: localization.amount,
                        value: formatNumber(payment.amount, context,
                            clientId: client.id),
                        secondLabel: localization.applied,
                        secondValue: formatNumber(payment.applied, context,
                            clientId: client.id),
                      ),
                      ListDivider(),
                      EntityListTile(
                        isFilter: widget.isFilter,
                        entity: client,
                      ),
                      for (final paymentable in payment.invoicePaymentables)
                        EntityListTile(
                          isFilter: widget.isFilter,
                          entity: state.invoiceState.map[paymentable.invoiceId],
                          subtitle: formatNumber(paymentable.amount, context) +
                              ' • ' +
                              formatDate(
                                  convertTimestampToDateString(
                                      paymentable.createdAt),
                                  context),
                        ),
                      for (final paymentable in payment.creditPaymentables)
                        EntityListTile(
                          isFilter: widget.isFilter,
                          entity: state.creditState.map[paymentable.creditId],
                          subtitle: formatNumber(paymentable.amount, context) +
                              ' • ' +
                              formatDate(
                                  convertTimestampToDateString(
                                      paymentable.createdAt),
                                  context),
                        ),
                      if ((payment.companyGatewayId ?? '').isNotEmpty)
                        EntityListTile(
                          entity: state.companyGatewayState
                              .get(payment.companyGatewayId),
                          client: client,
                          isFilter: widget.isFilter,
                          onEntityActionSelected: (context, entity, action) {
                            /*
                            if (action == EntityAction.viewInStripe) {
                              final companyGateway = state.companyGatewayState
                                  .get(payment.companyGatewayId);
                              launch(GatewayEntity.getPaymentUrl(
                                  gatewayId: companyGateway.gatewayId,
                                  transactionReference:
                                  payment.transactionReference));
                            } else {
                              handleEntityAction(context, entity, action);
                            }
                             */
                          },
                        ),
                      payment.privateNotes != null &&
                              payment.privateNotes.isNotEmpty
                          ? Column(
                              children: <Widget>[
                                IconMessage(payment.privateNotes),
                                Container(
                                  color: Theme.of(context).cardColor,
                                  height: 12.0,
                                ),
                              ],
                            )
                          : Container(),
                      FieldGrid(fields),
                    ],
                  ),
                ),
                BottomButtons(
                  entity: payment,
                  action1: EntityAction.refund,
                  action1Enabled: payment.refunded < payment.amount,
                  action2: EntityAction.archive,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
