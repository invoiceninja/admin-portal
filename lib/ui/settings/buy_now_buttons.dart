import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/buy_now_buttons_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class BuyNowButtons extends StatefulWidget {
  const BuyNowButtons({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final BuyNowButtonsVM viewModel;

  @override
  _BuyNowButtonsState createState() => _BuyNowButtonsState();
}

class _BuyNowButtonsState extends State<BuyNowButtons> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_buyNowButtons');

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

    return WillPopScope(
      onWillPop: () async {
        //viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: isMobile(context),
          title: Text(localization.buyNowButtons),
          actions: <Widget>[],
        ),
        body: Form(
          key: _formKey,
          child: ScrollableListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  DecoratedFormField(
                    label: localization.firstName,
                    controller: _firstNameController,
                    validator: (val) => val.isEmpty || val.trim().isEmpty
                        ? localization.pleaseEnterAFirstName
                        : null,
                    autovalidate: autoValidate,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
