import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_item_view.dart';
import 'package:invoiceninja_flutter/ui/app/two_value_header.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class QuoteView extends StatefulWidget {
  final QuoteViewVM viewModel;

  const QuoteView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _QuoteViewState createState() => new _QuoteViewState();
}

class _QuoteViewState extends State<QuoteView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final client = viewModel.client;
    final company = viewModel.company;

    List<Widget> _buildView() {
      final quote = widget.viewModel.quote;
      final user = widget.viewModel.company.user;
      final widgets = <Widget>[
        TwoValueHeader(
          backgroundColor: quote.isPastDue
              ? Colors.red
              : InvoiceStatusColors.colors[quote.invoiceStatusId],
          label1: localization.totalAmount,
          value1: formatNumber(quote.amount, context, clientId: quote.clientId),
          label2: localization.balanceDue,
          value2:
              formatNumber(quote.balance, context, clientId: quote.clientId),
        ),
      ];

      final Map<String, String> fields = {
        InvoiceFields.invoiceStatusId: quote.isPastDue
            ? localization.pastDue
            : localization.lookup('quote_status_${quote.invoiceStatusId}'),
        InvoiceFields.invoiceDate: formatDate(quote.invoiceDate, context),
        InvoiceFields.dueDate: formatDate(quote.dueDate, context),
        InvoiceFields.partial: formatNumber(quote.partial, context,
            clientId: quote.clientId, zeroIsNull: true),
        InvoiceFields.partialDueDate: formatDate(quote.partialDueDate, context),
        InvoiceFields.poNumber: quote.poNumber,
        InvoiceFields.discount: formatNumber(quote.discount, context,
            clientId: quote.clientId,
            zeroIsNull: true,
            formatNumberType: quote.isAmountDiscount
                ? FormatNumberType.money
                : FormatNumberType.percent),
      };

      if (quote.customTextValue1.isNotEmpty) {
        final label1 = company.getCustomFieldLabel(CustomFieldType.invoice1);
        fields[label1] = quote.customTextValue1;
      }
      if (quote.customTextValue2.isNotEmpty) {
        final label2 = company.getCustomFieldLabel(CustomFieldType.invoice2);
        fields[label2] = quote.customTextValue2;
      }

      final List<Widget> fieldWidgets = [];
      fields.forEach((field, value) {
        if (value != null && value.isNotEmpty) {
          fieldWidgets.add(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  localization.lookup(field),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Flexible(
                  child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )),
            ],
          ));
        }
      });

      widgets.addAll([
        Material(
          color: Theme.of(context).canvasColor,
          child: ListTile(
            title: Text(client?.displayName ?? ''),
            leading: Icon(FontAwesomeIcons.users, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () => viewModel.onClientPressed(context),
          ),
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
        Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: true,
              crossAxisCount: 2,
              children: fieldWidgets,
              childAspectRatio: 3.5,
            ),
          ),
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
      ]);

      if (quote.privateNotes != null && quote.privateNotes.isNotEmpty) {
        widgets.addAll([
          IconMessage(quote.privateNotes),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        ]);
      }

      quote.invoiceItems.forEach((quoteItem) {
        widgets.addAll([
          InvoiceItemListTile(
            invoice: quote,
            invoiceItem: quoteItem,
            onTap: () => user.canEditEntity(quote)
                ? viewModel.onEditPressed(context, quoteItem)
                : null,
          ),
        ]);
      });

      widgets.addAll([
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
      ]);

      Widget surchargeRow(String label, double amount) {
        return Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 12.0, right: 16.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(label),
                SizedBox(
                  width: 80.0,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(formatNumber(amount, context,
                          clientId: quote.clientId))),
                ),
              ],
            ),
          ),
        );
      }

      if (quote.customValue1 != 0 && company.enableCustomInvoiceTaxes1) {
        widgets.add(surchargeRow(
            company.getCustomFieldLabel(CustomFieldType.surcharge1),
            quote.customValue1));
      }

      if (quote.customValue2 != 0 && company.enableCustomInvoiceTaxes2) {
        widgets.add(surchargeRow(
            company.getCustomFieldLabel(CustomFieldType.surcharge2),
            quote.customValue2));
      }

      quote
          .calculateTaxes(company.enableInclusiveTaxes)
          .forEach((taxName, taxAmount) {
        widgets.add(surchargeRow(taxName, taxAmount));
      });

      if (quote.customValue1 != 0 && !company.enableCustomInvoiceTaxes1) {
        widgets.add(surchargeRow(
            company.getCustomFieldLabel(CustomFieldType.surcharge1),
            quote.customValue1));
      }

      if (quote.customValue2 != 0 && !company.enableCustomInvoiceTaxes2) {
        widgets.add(surchargeRow(
            company.getCustomFieldLabel(CustomFieldType.surcharge2),
            quote.customValue2));
      }

      return widgets;
    }

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: _CustomAppBar(
          viewModel: viewModel,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: ListView(
                  children: _buildView(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    @required this.viewModel,
  });

  final QuoteViewVM viewModel;

  @override
  final Size preferredSize = const Size(double.infinity, 54.0);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final quote = viewModel.quote;
    final client = viewModel.client;
    final user = viewModel.company.user;

    return AppBar(
      title: Text((localization.quote + ' ' + quote.invoiceNumber) ?? ''),
      actions: quote.isNew
          ? []
          : [
              user.canEditEntity(quote)
                  ? EditIconButton(
                      isVisible: !quote.isDeleted,
                      onPressed: () => viewModel.onEditPressed(context),
                    )
                  : Container(),
              ActionMenuButton(
                user: user,
                customActions: [
                  user.canCreate(EntityType.quote)
                      ? ActionMenuChoice(
                          action: EntityAction.clone,
                          icon: Icons.control_point_duplicate,
                          label: AppLocalization.of(context).clone,
                        )
                      : null,
                  user.canEditEntity(quote) && !quote.isPublic
                      ? ActionMenuChoice(
                          action: EntityAction.markSent,
                          icon: Icons.publish,
                          label: AppLocalization.of(context).markSent,
                        )
                      : null,
                  user.canEditEntity(quote) && client.hasEmailAddress
                      ? ActionMenuChoice(
                          action: EntityAction.emailInvoice,
                          icon: Icons.send,
                          label: AppLocalization.of(context).email,
                        )
                      : null,
                  ActionMenuChoice(
                    action: EntityAction.pdf,
                    icon: Icons.picture_as_pdf,
                    label: AppLocalization.of(context).pdf,
                  ),
                ],
                isSaving: viewModel.isSaving,
                entity: quote,
                onSelected: viewModel.onActionSelected,
              )
            ],
    );
  }
}
