import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/ui/app/entity_dropdown.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/redux/static/static_selectors.dart';

class ClientEditSettings extends StatefulWidget {
  const ClientEditSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  ClientEditSettingsState createState() => new ClientEditSettingsState();
}

class ClientEditSettingsState extends State<ClientEditSettings> {

  final _taskRateController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
      _taskRateController
    ];

    _controllers.forEach((dynamic controller) => controller.removeListener(_onChanged));

    final client = widget.viewModel.client;
    _taskRateController.text = formatNumber(
        client.taskRate, widget.viewModel.state,
        formatNumberType: FormatNumberType.input);

    _controllers.forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final client = viewModel.client.rebuild((b) => b
      ..taskRate = double.tryParse(_taskRateController.text) ?? 0.0
    );
    if (client != viewModel.client) {
      viewModel.onChanged(client);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final client = viewModel.client;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            EntityDropdown(
              entityType: EntityType.currency,
              entityMap: viewModel.currencyMap,
              entityList: memoizedCurrencyList(viewModel.currencyMap),
              labelText: localization.currency,
              initialValue: viewModel.currencyMap[client.currencyId]?.name,
              onSelected: (int currencyId) => viewModel
                  .onChanged(client.rebuild((b) => b..currencyId = currencyId)),
            ),
            EntityDropdown(
              entityType: EntityType.language,
              entityMap: viewModel.languageMap,
              entityList: memoizedLanguageList(viewModel.languageMap),
              labelText: localization.language,
              initialValue: viewModel.languageMap[client.languageId]?.name,
              onSelected: (int languageId) => viewModel
                  .onChanged(client.rebuild((b) => b..languageId = languageId)),
            ),
            TextFormField(
              autocorrect: false,
              controller: _taskRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: localization.taskRate,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
