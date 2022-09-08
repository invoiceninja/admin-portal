import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/bank_account/view/bank_account_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';

class BankAccountView extends StatefulWidget {
  const BankAccountView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final BankAccountViewVM viewModel;
  final bool isFilter;

  @override
  _BankAccountViewState createState() => new _BankAccountViewState();
}

class _BankAccountViewState extends State<BankAccountView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final bankAccount = viewModel.bankAccount;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: bankAccount,
      body: ScrollableListView(
        children: <Widget>[],
      ),
    );
  }
}
