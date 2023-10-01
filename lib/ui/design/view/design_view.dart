// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';

// Package imports:
import 'package:timeago/timeago.dart' as timeago;

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DesignView extends StatefulWidget {
  const DesignView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final DesignViewVM viewModel;
  final bool isFilter;

  @override
  _DesignViewState createState() => new _DesignViewState();
}

class _DesignViewState extends State<DesignView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = state.company;
    final design = viewModel.design;
    final localization = AppLocalization.of(context)!;

    int count = 0;

    count += state.invoiceState.list
        .map((invoiceId) => state.invoiceState.map[invoiceId])
        .where(
            (invoice) => !invoice!.isDeleted! && invoice.designId == design.id)
        .length;

    count += state.quoteState.list
        .map((quoteId) => state.quoteState.map[quoteId])
        .where((quote) => !quote!.isDeleted! && quote.designId == design.id)
        .length;

    count += state.creditState.list
        .map((creditId) => state.creditState.map[creditId])
        .where((credit) => !credit!.isDeleted! && credit.designId == design.id)
        .length;

    count += state.recurringInvoiceState.list
        .map((invoiceId) => state.recurringInvoiceState.map[invoiceId])
        .where(
            (invoice) => !invoice!.isDeleted! && invoice.designId == design.id)
        .length;

    return ViewScaffold(
        isFilter: widget.isFilter,
        entity: design,
        onBackPressed: () => viewModel.onBackPressed(),
        body: ScrollableListView(
          children: [
            EntityHeader(
              entity: design,
              value: '$count',
              label: localization.count,
              secondLabel: localization.lastUpdated,
              secondValue: timeago.format(
                  convertTimestampToDate(design.updatedAt),
                  locale: localeSelector(state, twoLetter: true)),
            ),
            ListDivider(),
            if (company.isModuleEnabled(EntityType.invoice))
              EntitiesListTile(
                entity: design,
                isFilter: widget.isFilter,
                title: localization.invoices,
                entityType: EntityType.invoice,
                subtitle: memoizedInvoiceStatsForDesign(
                        design.id, state.invoiceState.map)
                    .present(localization.active, localization.archived),
              ),
            if (company.isModuleEnabled(EntityType.quote))
              EntitiesListTile(
                entity: design,
                isFilter: widget.isFilter,
                title: localization.quotes,
                entityType: EntityType.quote,
                subtitle:
                    memoizedQuoteStatsForDesign(design.id, state.quoteState.map)
                        .present(localization.active, localization.archived),
              ),
            if (company.isModuleEnabled(EntityType.credit))
              EntitiesListTile(
                entity: design,
                isFilter: widget.isFilter,
                title: localization.credits,
                entityType: EntityType.credit,
                subtitle: memoizedCreditStatsForDesign(
                        design.id, state.creditState.map)
                    .present(localization.active, localization.archived),
              ),
            if (company.isModuleEnabled(EntityType.recurringInvoice))
              EntitiesListTile(
                entity: design,
                isFilter: widget.isFilter,
                title: localization.recurringInvoices,
                entityType: EntityType.recurringInvoice,
                subtitle: memoizedRecurringInvoiceStatsForDesign(
                        design.id, state.recurringInvoiceState.map)
                    .present(localization.active, localization.archived),
              ),
          ],
        ));
  }
}
