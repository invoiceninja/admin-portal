// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_list_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_presenter.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({
    Key? key,
    required this.viewModel,
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
    final statuses = [
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kQuoteStatusDraft
          ..name = localization!.draft,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kQuoteStatusSent
          ..name = localization!.sent,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kQuoteStatusViewed
          ..name = localization!.viewed,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kQuoteStatusApproved
          ..name = localization!.approved,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kQuoteStatusConverted
          ..name = localization!.converted,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kQuoteStatusExpired
          ..name = localization!.expired,
      ),
    ];

    return ListScaffold(
      entityType: EntityType.quote,
      onHamburgerLongPress: () => store.dispatch(StartQuoteMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.quoteListState.filterClearedAt}__'),
        entityType: EntityType.quote,
        entityIds: viewModel.quoteList,
        filter: state.quoteListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterQuotes(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterQuotesByState(state));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterQuotesByStatus(status));
        },
        statuses: statuses,
      ),
      onCheckboxPressed: () {
        if (store.state.quoteListState.isInMultiselect()) {
          store.dispatch(ClearQuoteMultiselect());
        } else {
          store.dispatch(StartQuoteMultiselect());
        }
      },
      body: QuoteListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.quote,
        tableColumns: QuotePresenter.getAllTableFields(userCompany),
        defaultTableColumns: QuotePresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) => store.dispatch(SortQuotes(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.invoice1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.invoice2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.invoice3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.invoice4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterQuotesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterQuotesByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterQuotesByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterQuotesByCustom4(value)),
        sortFields: [
          QuoteFields.number,
          QuoteFields.date,
          QuoteFields.validUntil,
          QuoteFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterQuotesByState(state));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterQuotesByStatus(status));
        },
        statuses: statuses,
        onCheckboxPressed: () {
          if (store.state.quoteListState.isInMultiselect()) {
            store.dispatch(ClearQuoteMultiselect());
          } else {
            store.dispatch(StartQuoteMultiselect());
          }
        },
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.quote)
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
              tooltip: localization!.newQuote,
            )
          : null,
    );
  }
}
