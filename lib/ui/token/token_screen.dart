// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/token/token_list_vm.dart';
import 'package:invoiceninja_flutter/ui/token/token_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'token_screen_vm.dart';

class TokenScreen extends StatelessWidget {
  const TokenScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsTokens';

  final TokenScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    //final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.token,
      onHamburgerLongPress: () => store.dispatch(StartTokenMultiselect()),
      onCancelSettingsSection: kSettingsAccountManagement,
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.tokenListState.filterClearedAt}__'),
        entityType: EntityType.token,
        entityIds: viewModel.tokenList,
        filter: state.tokenListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterTokens(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTokensByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.tokenListState.isInMultiselect()) {
          store.dispatch(ClearTokenMultiselect());
        } else {
          store.dispatch(StartTokenMultiselect());
        }
      },
      body: TokenListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.token,
        tableColumns: TokenPresenter.getAllTableFields(userCompany),
        defaultTableColumns: TokenPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortTokens(value));
        },
        sortFields: [
          TokenFields.name,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTokensByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.tokenListState.isInMultiselect()) {
            store.dispatch(ClearTokenMultiselect());
          } else {
            store.dispatch(StartTokenMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterTokensByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterTokensByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterTokensByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterTokensByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.token)
          ? FloatingActionButton(
              heroTag: 'token_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.token);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newToken,
            )
          : null,
    );
  }
}
