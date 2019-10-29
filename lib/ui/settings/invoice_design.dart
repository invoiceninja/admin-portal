import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/settings/invoice_design_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceDesign extends StatefulWidget {
  const InvoiceDesign({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final InvoiceDesignVM viewModel;

  @override
  _InvoiceDesignState createState() => _InvoiceDesignState();
}

class _InvoiceDesignState extends State<InvoiceDesign>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TabController _controller;
  FocusScopeNode _focusNode;

  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
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
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    //final settings = viewModel.;

    return SettingsScaffold(
      title: localization.invoiceDesign,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        tabs: [
          Tab(
            text: localization.settings,
          ),
          Tab(
            text: localization.invoiceFields,
          ),
          Tab(
            text: localization.productFields,
          ),
        ],
      ),
      body: AppTabForm(
        tabController: _controller,
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          ListView(children: <Widget>[
            FormCard(
              children: <Widget>[
                /*
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: localization.firstMonthOfTheYear,
                  ),
                  //isEmpty: company.financialYearStart == null,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                        value: company.financialYearStart,
                        isExpanded: true,
                        isDense: true,
                        onChanged: (value) => viewModel.onCompanyChanged(company
                            .rebuild((b) => b..financialYearStart = value)),
                        items: kMonthsOfTheYear
                            .map((id, month) =>
                            MapEntry<int, DropdownMenuItem<int>>(
                                id,
                                DropdownMenuItem<int>(
                                  child: Text(localization.lookup(month)),
                                  value: id,
                                )))
                            .values
                            .toList()),
                  ),
                )

                 */
              ],
            ),
          ]),
          ListView(),
          ListView(),
        ],
      ),
    );
  }
}
