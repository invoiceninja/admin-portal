import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';

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
  final _paymentTermsController = TextEditingController();

  List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    final localization = AppLocalization.of(context);
    _controllers = [
      _taskRateController,
      _paymentTermsController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final client = widget.viewModel.client;
    _taskRateController.text = formatNumber(
        client.settings.defaultTaskRate, context,
        formatNumberType: FormatNumberType.input);
    _paymentTermsController.text = client.getPaymentTerm(localization.net);

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

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
    _debouncer.run(() {
      final viewModel = widget.viewModel;
      final client = viewModel.client.rebuild((b) => b
        ..settings.defaultTaskRate =
            parseDouble(_taskRateController.text, zeroIsNull: true));
      if (client != viewModel.client) {
        viewModel.onChanged(client);
      }
    });
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
              key: ValueKey('__currency_${client.currencyId}__'),
              entityType: EntityType.currency,
              entityList:
                  memoizedCurrencyList(viewModel.staticState.currencyMap),
              labelText: localization.currency,
              entityId: client.currencyId,
              allowClearing: true,
              onSelected: (SelectableEntity currency) => viewModel.onChanged(
                  client.rebuild((b) => b..settings.currencyId = currency?.id)),
            ),
            EntityDropdown(
              key: ValueKey('__language_${client.languageId}__'),
              allowClearing: true,
              entityType: EntityType.language,
              entityList:
                  memoizedLanguageList(viewModel.staticState.languageMap),
              labelText: localization.language,
              entityId: client.languageId,
              onSelected: (SelectableEntity language) => viewModel.onChanged(
                  client.rebuild((b) => b..settings.languageId = language?.id)),
            ),
            PopupMenuButton<PaymentTermEntity>(
              padding: EdgeInsets.zero,
              initialValue: null,
              itemBuilder: (BuildContext context) => (<int>[]
                    ..addAll(kPaymentTerms)
                    ..addAll(viewModel.company.settings.customPaymentTerms
                        .map((paymentTerm) => paymentTerm.numDays))
                    ..sort((a, b) => a.abs() - b.abs()))
                  .map((int numDays) =>
                      PaymentTermEntity().rebuild((b) => b..numDays = numDays))
                  .map((paymentTerm) => PopupMenuItem<PaymentTermEntity>(
                        value: paymentTerm,
                        child:
                            Text(paymentTerm.getPaymentTerm(localization.net)),
                      ))
                  .toList(),
              onSelected: (paymentTerm) {
                viewModel.onChanged(client.rebuild((b) =>
                    b..settings.defaultPaymentTerms = paymentTerm.numDays));
                _paymentTermsController.text =
                    paymentTerm.getPaymentTerm(localization.net);
              },
              child: InkWell(
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _paymentTermsController,
                    decoration: InputDecoration(
                      labelText: localization.paymentTerms,
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
              ),
            ),
            DecoratedFormField(
              controller: _taskRateController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              label: localization.taskRate,
            ),
          ],
        ),
        // TODO renable this code
        /*
        FormCard(children: <Widget>[
          SwitchListTile(
            activeColor: Theme.of(context).accentColor,
            title: Text(localization.clientPortal),
            subtitle: Text(localization.showTasks),
            value: client.settings.showTasksInPortal,
            onChanged: (value) => viewModel.onChanged(
                client.rebuild((b) => b..settings.showTasksInPortal = value)),
          ),
          SwitchListTile(
            activeColor: Theme.of(context).accentColor,
            title: Text(localization.emailReminders),
            subtitle: Text(localization.enabled),
            value: client.settings.sendReminders,
            onChanged: (value) => viewModel.onChanged(
                client.rebuild((b) => b..settings.sendReminders = value)),
          ),
        ]),
         */
      ],
    );
  }
}
