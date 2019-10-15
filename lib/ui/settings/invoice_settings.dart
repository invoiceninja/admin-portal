import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/settings/invoice_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceSettings extends StatefulWidget {
  const InvoiceSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final InvoiceSettingsVM viewModel;

  @override
  _InvoiceSettingsState createState() => _InvoiceSettingsState();
}

class _InvoiceSettingsState extends State<InvoiceSettings>
    with SingleTickerProviderStateMixin {
  //static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TabController _controller;

  bool autoValidate = false;

  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [_nameController];

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

  void _onChanged() {
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    //final viewModel = widget.viewModel;

    return SettingsScaffold(
      title: localization.invoiceSettings,
      onSavePressed: null,
      body: SizedBox(),
    );
  }
}
