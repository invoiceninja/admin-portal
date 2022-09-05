// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/settings/bank_accounts_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BankAccounts extends StatefulWidget {
  const BankAccounts({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final BankAccountsVM viewModel;

  @override
  _BankAccountsState createState() => _BankAccountsState();
}

class _BankAccountsState extends State<BankAccounts> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_BankAccounts');
  FocusScopeNode _focusNode;
  final _debouncer = Debouncer(sendFirstAction: true);
  final _stockThresholdController = TextEditingController();
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

  @override
  void didChangeDependencies() {
    _controllers = [_stockThresholdController];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final viewModel = widget.viewModel;
    final company = viewModel.state.company;

    _stockThresholdController.text = company.stockNotificationThreshold == 0
        ? ''
        : formatNumber(
            company.stockNotificationThreshold.toDouble(),
            context,
            formatNumberType: FormatNumberType.int,
          );

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  void _onChanged() {
    final company = widget.viewModel.company.rebuild((b) => b
      ..stockNotificationThreshold =
          parseInt(_stockThresholdController.text.trim()));
    if (company != widget.viewModel.company) {
      _debouncer.run(() {
        widget.viewModel.onCompanyChanged(company);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    //final company = viewModel.company;

    return EditScaffold(
      title: localization.bankAccounts,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: localization.connect.toUpperCase(),
                    onPressed: () => viewModel.onConnectAccounts(),
                    iconData: Icons.link,
                  ),
                ),
                SizedBox(width: kGutterWidth),
                Expanded(
                  child: AppButton(
                    label: localization.refresh.toUpperCase(),
                    onPressed: () => viewModel.onConnectAccounts(),
                    iconData: Icons.refresh,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
