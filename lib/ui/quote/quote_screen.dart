import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_list_vm.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/quote';

  final QuoteScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = store.state.company;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.quoteUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.quoteList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () =>
          store.dispatch(StartQuoteMultiselect()),
      onCheckboxChanged: (value) {
        final quotes = viewModel.quoteList
            .map<InvoiceEntity>((quoteId) => viewModel.quoteMap[quoteId])
            .where((quote) => value != listUIState.isSelected(quote.id))
            .toList();

        handleQuoteAction(context, quotes, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.quotes,
        key: ValueKey(store.state.quoteListState.filterClearedAt),
        filter: state.quoteListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterQuotes(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.quoteListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterQuotes(value));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            child: Text(
              localization.cancel,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              store.dispatch(ClearQuoteMultiselect());
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            textColor: Colors.white,
            disabledTextColor: Colors.white54,
            child: Text(
              localization.done,
            ),
            onPressed: state.quoteListState.selectedIds.isEmpty
                ? null
                : () async {
                    final quotes = viewModel.quoteList
                        .map<InvoiceEntity>(
                            (quoteId) => viewModel.quoteMap[quoteId])
                        .toList();

                    await showEntityActionsDialog(
                        entities: quotes, context: context, multiselect: true);
                    store.dispatch(ClearQuoteMultiselect());
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
                createEntityByType(
                    context: context, entityType: EntityType.quote);
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
