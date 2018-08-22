import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_starter/ui/app/actions_menu_button.dart';
import 'package:flutter_redux_starter/ui/quote/view/quote_view_vm.dart';
import 'package:flutter_redux_starter/ui/app/form_card.dart';

class QuoteView extends StatefulWidget {
  final QuoteViewVM viewModel;

  QuoteView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _QuoteViewState createState() => new _QuoteViewState();
}

class _QuoteViewState extends State<QuoteView> {
  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;
    var quote = viewModel.quote;

    return Scaffold(
      appBar: AppBar(
        title: Text(quote.displayName),
        actions: quote.isNew
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    viewModel.onEditPressed(context);
                  },
                ),
                ActionMenuButton(
                  isLoading: viewModel.isLoading,
                  entity: quote,
                  onSelected: viewModel.onActionSelected,
                )
              ],
      ),
      body: FormCard(
        children: [
          // STARTER: widgets - do not remove comment
        ]
      ),
    );
  }
}
