import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_list_vm.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class QuoteScreen extends StatelessWidget {
  static const String route = '/quote';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(store.state.quoteListState.filterClearedAt),
        entityType: EntityType.quote,
        onFilterChanged: (value) {
          store.dispatch(FilterQuotes(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.quote,
          onFilterPressed: (String value) {
            store.dispatch(FilterQuotes(value));
          },
        ),
      ],
      body: QuoteListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.quote,
        onSelectedSortField: (value) => store.dispatch(SortQuotes(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.invoice1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.invoice2,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterQuotesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterQuotesByCustom2(value)),
        sortFields: [
          QuoteFields.quoteNumber,
          QuoteFields.quoteDate,
          QuoteFields.validUntil,
          QuoteFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterQuotesByState(state));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterQuotesByStatus(status));
        },
        statuses: [
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusDraft
              ..name = localization.draft,
          ),
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusSent
              ..name = localization.sent,
          ),
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusViewed
              ..name = localization.viewed,
          ),
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusApproved
              ..name = localization.approved,
          ),
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusPastDue
              ..name = localization.expired,
          ),
        ],
      ),
      floatingActionButton: userCompany.canCreate(EntityType.quote)
          ? FloatingActionButton(
              heroTag: 'quote_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(EditQuote(
                    quote: InvoiceEntity(company: company, isQuote: true)
                        .rebuild((b) => b
                          ..clientId =
                              store.state.quoteListState.filterEntityId ?? 0),
                    context: context));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newQuote,
            )
          : null,
    );
  }
}
