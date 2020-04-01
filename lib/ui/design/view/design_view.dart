import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';

class DesignView extends StatefulWidget {
  const DesignView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DesignViewVM viewModel;

  @override
  _DesignViewState createState() => new _DesignViewState();
}

class _DesignViewState extends State<DesignView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final design = viewModel.design;

    return ViewScaffold(
      entity: design,
      isSettings: true,
      onBackPressed: () => viewModel.onBackPressed(),
      body: Placeholder(),
    );
  }
}
