import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class TemplatesAndReminders extends StatefulWidget {
  const TemplatesAndReminders({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TemplatesAndRemindersVM viewModel;

  @override
  _TemplatesAndRemindersState createState() => _TemplatesAndRemindersState();
}

class _TemplatesAndRemindersState extends State<TemplatesAndReminders>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusScopeNode _focusNode;
  TabController _controller;

  bool autoValidate = false;

  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _controller = TabController(vsync: this, length: 7);
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
    final viewModel = widget.viewModel;
    final state = viewModel.state;

    return SettingsScaffold(
      title: localization.templatesAndReminders,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.invoices,
          ),
          Tab(
            text: localization.quotes,
          ),
          Tab(
            text: localization.payments,
          ),
          Tab(
            text: localization.firstReminder,
          ),
          Tab(
            text: localization.secondReminder,
          ),
          Tab(
            text: localization.thirdReminder,
          ),
          Tab(
            text: localization.endlessReminder,
          ),
        ],
      ),
      body: AppTabForm(
        tabController: _controller,
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          TemplateEditor(),
          TemplateEditor(),
          TemplateEditor(),
          TemplateEditor(),
          TemplateEditor(),
          TemplateEditor(),
          TemplateEditor(),
        ],
      ),
    );
  }
}

class TemplateEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text('test')
      ],
    );
  }
}
