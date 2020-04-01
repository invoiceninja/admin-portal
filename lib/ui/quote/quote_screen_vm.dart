import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:redux/redux.dart';

import 'quote_screen.dart';

class QuoteScreenBuilder extends StatelessWidget {
  const QuoteScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteScreenVM>(
      converter: QuoteScreenVM.fromStore,
      builder: (context, vm) {
        return QuoteScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class QuoteScreenVM {
  QuoteScreenVM({
    @required this.isInMultiselect,
    @required this.quoteList,
    @required this.userCompany,
    @required this.quoteMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity userCompany;
  final List<String> quoteList;
  final BuiltMap<String, InvoiceEntity> quoteMap;

  static QuoteScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return QuoteScreenVM(
      quoteMap: state.quoteState.map,
      quoteList: memoizedFilteredQuoteList(state.quoteState.map,
          state.quoteState.list, state.clientState.map, state.quoteListState),
      userCompany: state.userCompany,
      isInMultiselect: state.quoteListState.isInMultiselect(),
    );
  }
}
