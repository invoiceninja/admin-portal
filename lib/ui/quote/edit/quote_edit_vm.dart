import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_starter/redux/ui/ui_actions.dart';
import 'package:flutter_redux_starter/ui/quote/quote_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_starter/redux/quote/quote_actions.dart';
import 'package:flutter_redux_starter/data/models/quote_model.dart';
import 'package:flutter_redux_starter/ui/quote/edit/quote_edit.dart';
import 'package:flutter_redux_starter/redux/app/app_state.dart';
import 'package:flutter_redux_starter/ui/app/icon_message.dart';

class QuoteEditScreen extends StatelessWidget {
  static final String route = '/quote/edit';
  QuoteEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditVM>(
      converter: (Store<AppState> store) {
        return QuoteEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return QuoteEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class QuoteEditVM {
  final QuoteEntity quote;
  final Function(QuoteEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final bool isLoading;

  QuoteEditVM({
    @required this.quote,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.isLoading,
  });

  factory QuoteEditVM.fromStore(Store<AppState> store) {
    final quote = store.state.quoteUIState.selected;

    return QuoteEditVM(
      isLoading: store.state.isLoading,
      quote: quote,
      onChanged: (QuoteEntity quote) {
        store.dispatch(UpdateQuote(quote));
      },
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(QuoteScreen.route));
      },
      onSavePressed: (BuildContext context) {
        final Completer<Null> completer = new Completer<Null>();
        store.dispatch(SaveQuoteRequest(completer: completer, quote: quote));
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: IconMessage(
                message: quote.isNew
                    ? 'Successfully Created Quote'
                    : 'Successfully Updated Quote',
              ),
              duration: Duration(seconds: 3)));
        });
      },
    );
  }
}
