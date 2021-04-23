import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DesignView extends StatefulWidget {
  const DesignView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final DesignViewVM viewModel;
  final bool isFilter;

  @override
  _DesignViewState createState() => new _DesignViewState();
}

class _DesignViewState extends State<DesignView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final design = viewModel.design;
    final localization = AppLocalization.of(context);

    int count = 0;

    count += state.invoiceState.list
        .map((invoiceId) => state.invoiceState.map[invoiceId])
        .where((invoice) => !invoice.isDeleted && invoice.designId == design.id)
        .length;

    count += state.quoteState.list
        .map((quoteId) => state.quoteState.map[quoteId])
        .where((quote) => !quote.isDeleted && quote.designId == design.id)
        .length;

    count += state.creditState.list
        .map((creditId) => state.creditState.map[creditId])
        .where((credit) => !credit.isDeleted && credit.designId == design.id)
        .length;

    return ViewScaffold(
        isFilter: widget.isFilter,
        entity: design,
        onBackPressed: () => viewModel.onBackPressed(),
        body: ScrollableListView(
          children: [
            EntityHeader(
              entity: design,
              value: '$count',
              label: localization.count,
            ),
          ],
        ));
  }
}
