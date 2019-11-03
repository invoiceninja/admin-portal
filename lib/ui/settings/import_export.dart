import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/settings/import_export_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ImportExport extends StatefulWidget {
  const ImportExport({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ImportExportVM viewModel;

  @override
  _ImportExportState createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
  //static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _debouncer = Debouncer();

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
    final localization = AppLocalization.of(context);
    //final viewModel = widget.viewModel;

    return SettingsScaffold(
      title: localization.importExport,
      onSavePressed: null,
      body: SizedBox(),
    );
  }
}
