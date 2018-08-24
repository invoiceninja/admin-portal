import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_list_vm.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class QuoteScreen extends StatelessWidget {
  static const String route = '/quote';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: ListFilter(
            entityType: EntityType.quote,
            onFilterChanged: (value) {
              store.dispatch(FilterQuotes(value));
            },
          ),
          actions: [
            ListFilterButton(
              entityType: EntityType.quote,
              onFilterPressed: (String value) {
                store.dispatch(FilterQuotes(value));
              },
            ),
          ],
        ),
        drawer: AppDrawerBuilder(),
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
            InvoiceFields.updatedAt,
          ],
          onSelectedState: (EntityState state, value) {
            store.dispatch(FilterQuotesByState(state));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: user.canCreate(EntityType.quote)
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () {
                  store.dispatch(
                      EditQuote(quote: InvoiceEntity(isQuote: true), context: context));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: localization.newQuote,
              )
            : null,
      ),
    );
  }
}
