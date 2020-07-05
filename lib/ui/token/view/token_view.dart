import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/token/view/token_view_vm.dart';

class TokenView extends StatefulWidget {
  const TokenView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final TokenViewVM viewModel;
  final bool isFilter;

  @override
  _TokenViewState createState() => new _TokenViewState();
}

class _TokenViewState extends State<TokenView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    //final userCompany = viewModel.state.userCompany;
    final token = viewModel.token;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: token,
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
