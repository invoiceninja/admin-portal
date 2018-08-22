import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_starter/ui/app/form_card.dart';
import 'package:flutter_redux_starter/ui/quote/edit/quote_edit_vm.dart';
import 'package:flutter_redux_starter/ui/app/save_icon_button.dart';

class QuoteEdit extends StatefulWidget {
  final QuoteEditVM viewModel;

  QuoteEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _QuoteEditState createState() => _QuoteEditState();
}

class _QuoteEditState extends State<QuoteEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // STARTER: controllers - do not remove comment

  var _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    var quote = widget.viewModel.quote;
    // STARTER: read value - do not remove comment

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  _onChanged() {
    var quote = widget.viewModel.quote.rebuild((b) => b
      // STARTER: set value - do not remove comment
    );
    if (quote != widget.viewModel.quote) {
      widget.viewModel.onChanged(quote);
    }
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.quote.isNew
              ? 'New Quote'
              : viewModel.quote.displayName),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return SaveIconButton(
                isLoading: viewModel.isLoading,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  viewModel.onSavePressed(context);
                },
              );
            }),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  // STARTER: widgets - do not remove comment
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
