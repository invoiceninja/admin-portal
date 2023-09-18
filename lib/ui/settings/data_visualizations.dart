// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/data_visualizations_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DataVisualizations extends StatefulWidget {
  const DataVisualizations({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DataVisualizationsVM viewModel;

  @override
  _DataVisualizationsState createState() => _DataVisualizationsState();
}

class _DataVisualizationsState extends State<DataVisualizations> {
  //static final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: '_dataVisualizations');

  bool autoValidate = false;

  final _firstNameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [_firstNameController];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    /*
    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
      */

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {}

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    //final viewModel = widget.viewModel;

    return EditScaffold(
      body: SizedBox(),
      onSavePressed: null,
      title: localization.dataVisualizations,
    );
  }
}
