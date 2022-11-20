import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/view/transaction_rule_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';

class TransactionRuleView extends StatefulWidget {
  const TransactionRuleView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final TransactionRuleViewVM viewModel;
  final bool isFilter;

  @override
  _TransactionRuleViewState createState() => new _TransactionRuleViewState();
}

class _TransactionRuleViewState extends State<TransactionRuleView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final transactionRule = viewModel.transactionRule;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: transactionRule,
      body: ScrollableListView(
        children: <Widget>[],
      ),
    );
  }
}
