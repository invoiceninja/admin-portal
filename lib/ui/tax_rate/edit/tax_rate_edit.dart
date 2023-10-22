// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/edit/tax_rate_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaxRateEdit extends StatefulWidget {
  const TaxRateEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TaxRateEditVM viewModel;

  @override
  _TaxRateEditState createState() => _TaxRateEditState();
}

class _TaxRateEditState extends State<TaxRateEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_taxRateEdit');

  FocusScopeNode? _focusNode;

  final _nameController = TextEditingController();
  final _rateController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
      _rateController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final taxRate = widget.viewModel.taxRate;
    _nameController.text = taxRate.name;
    _rateController.text = formatNumber(taxRate.rate, context,
        formatNumberType: FormatNumberType.inputMoney)!;

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

  void _onChanged() {
    final taxRate = widget.viewModel.taxRate.rebuild((b) => b
      ..name = _nameController.text.trim()
      ..rate = parseDouble(_rateController.text));
    if (taxRate != widget.viewModel.taxRate) {
      _debouncer.run(() {
        widget.viewModel.onChanged(taxRate);
      });
    }
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context)!;

    return EditScaffold(
      entity: viewModel.taxRate,
      title: viewModel.taxRate.isNew
          ? localization.newTaxRate
          : localization.editTaxRate,
      onSavePressed: _onSavePressed,
      onCancelPressed: viewModel.onCancelPressed,
      body: AppForm(
        focusNode: _focusNode,
        formKey: _formKey,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              DecoratedFormField(
                autofocus: true,
                label: localization.name,
                controller: _nameController,
                validator: (val) => val.isEmpty || val.trim().isEmpty
                    ? localization.pleaseEnterAName
                    : null,
                onSavePressed: _onSavePressed,
                keyboardType: TextInputType.text,
              ),
              DecoratedFormField(
                label: localization.rate,
                controller: _rateController,
                isPercent: true,
                onSavePressed: _onSavePressed,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          )
        ],
      ),
    );
  }
}
