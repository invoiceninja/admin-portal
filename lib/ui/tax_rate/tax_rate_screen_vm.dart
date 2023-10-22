// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_selectors.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class TaxRateScreenBuilder extends StatelessWidget {
  const TaxRateScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaxRateScreenVM>(
      converter: TaxRateScreenVM.fromStore,
      builder: (context, vm) {
        return TaxRateSettingsScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class TaxRateScreenVM {
  TaxRateScreenVM({
    required this.isInMultiselect,
    required this.taxRateList,
    required this.userCompany,
    required this.onBackPressed,
    required this.taxRateMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> taxRateList;
  final Function(BuildContext) onBackPressed;
  final BuiltMap<String?, TaxRateEntity?> taxRateMap;

  static TaxRateScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TaxRateScreenVM(
      taxRateMap: state.taxRateState.map,
      taxRateList: memoizedFilteredTaxRateList(
          state.getUISelection(EntityType.taxRate),
          state.taxRateState.map,
          state.taxRateState.list,
          state.taxRateListState),
      userCompany: state.userCompany,
      isInMultiselect: state.taxRateListState.isInMultiselect(),
      onBackPressed: (context) {
        if (isMobile(context)) {
          Navigator.pop(context);
        } else {
          store.dispatch(ViewSettings(section: kSettingsTaxSettings));
        }
      },
    );
  }
}
