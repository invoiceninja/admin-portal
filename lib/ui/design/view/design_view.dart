import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';

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
    final design = viewModel.design;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: design,
      onBackPressed: () => viewModel.onBackPressed(),
      body: Placeholder(),
    );
  }
}
