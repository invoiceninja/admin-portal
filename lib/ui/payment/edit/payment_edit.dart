import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/payment/edit/payment_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/refresh_icon_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentEdit extends StatefulWidget {
  final PaymentEditVM viewModel;

  PaymentEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _PaymentEditState createState() => _PaymentEditState();
}

class _PaymentEditState extends State<PaymentEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // STARTER: controllers - do not remove comment
  final _amountController = TextEditingController();

  final _transactionReferenceController = TextEditingController();

  final _privateNotesController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
      _transactionReferenceController,
      _privateNotesController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    var payment = widget.viewModel.payment;

    //_amountController.text = payment.amount;

    _transactionReferenceController.text = payment.transactionReference;

    _privateNotesController.text = payment.privateNotes;

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
    var payment = widget.viewModel.payment.rebuild((b) => b
      //..amount = _amountController.text.trim()
      ..transactionReference = _transactionReferenceController.text.trim()
      ..privateNotes = _privateNotesController.text.trim());
    if (payment != widget.viewModel.payment) {
      widget.viewModel.onChanged(payment);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final payment = viewModel.payment;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.payment.isNew
              ? 'New Payment'
              : viewModel.payment.transactionReference),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return RefreshIconButton(
                icon: Icons.cloud_upload,
                tooltip: AppLocalization.of(context).save,
                isVisible: !payment.isDeleted,
                isSaving: viewModel.isSaving,
                isDirty: payment.isNew || payment != viewModel.origPayment,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  viewModel.onSavePressed(context);
                },
              );
            }),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  // STARTER: widgets - do not remove comment
                  TextFormField(
                    controller: _amountController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
                  ),

                  TextFormField(
                    controller: _transactionReferenceController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'TransactionReference',
                    ),
                  ),

                  TextFormField(
                    controller: _privateNotesController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'PrivateNotes',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
