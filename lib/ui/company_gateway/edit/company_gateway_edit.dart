import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class CompanyGatewayEdit extends StatefulWidget {
  const CompanyGatewayEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayEditVM viewModel;

  @override
  _CompanyGatewayEditState createState() => _CompanyGatewayEditState();
}

class _CompanyGatewayEditState extends State<CompanyGatewayEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    //final companyGateway = widget.viewModel.companyGateway;
    // STARTER: read value - do not remove comment

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
    final companyGateway = widget.viewModel.companyGateway.rebuild((b) => b
      // STARTER: set value - do not remove comment
    );
    if (companyGateway != widget.viewModel.companyGateway) {
      widget.viewModel.onChanged(companyGateway);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final companyGateway = viewModel.companyGateway;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: isMobile(context),
          title: Text(viewModel.companyGateway.isNew
              ? localization.newCompanyGateway
              : localization.editCompanyGateway),
          actions: <Widget>[
                if (!isMobile(context))
                  FlatButton(
                    child: Text(
                      localization.cancel,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => viewModel.onCancelPressed(context),
                  ),
                ActionIconButton(
                  icon: Icons.cloud_upload,
                  tooltip: localization.save,
                  isVisible: !companyGateway.isDeleted,
                  isDirty: companyGateway.isNew || companyGateway != viewModel.origCompanyGateway,
                  isSaving: viewModel.isSaving,
                  onPressed: () {
                    if (! _formKey.currentState.validate()) {
                      return;
                    }
                    viewModel.onSavePressed(context);
                  },
                ),
          ],
        ),
        body: Form(
            key: _formKey,
            child: Builder(builder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      // STARTER: widgets - do not remove comment
                    ],
                  ),
                ],
              );
            })
        ),
      ),
    );
  }
}
