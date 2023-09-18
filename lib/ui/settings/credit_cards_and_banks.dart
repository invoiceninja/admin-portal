// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/credit_cards_and_banks_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CreditCardsAndBanks extends StatefulWidget {
  const CreditCardsAndBanks({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final CreditCardsAndBanksVM viewModel;

  @override
  _CreditCardsAndBanksState createState() => _CreditCardsAndBanksState();
}

class _CreditCardsAndBanksState extends State<CreditCardsAndBanks>
    with SingleTickerProviderStateMixin {
  //static final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: '_creditCardsAndBanks);

  late TabController _controller;

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

  void _onChanged() {}

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    //final viewModel = widget.viewModel;

    return EditScaffold(
      body: SizedBox(),
      onSavePressed: null,
      title: localization.creditCardsAndBanks,
    );
  }
}
