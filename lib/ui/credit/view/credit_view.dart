import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';

class CreditView extends StatefulWidget {
  const CreditView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CreditViewVM viewModel;

  @override
  _CreditViewState createState() => new _CreditViewState();
}

class _CreditViewState extends State<CreditView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final userCompany = viewModel.state.userCompany;
    final credit = viewModel.credit;

    return Scaffold(
      appBar: AppBar(
        title: EntityStateTitle(entity: credit),
        actions: [
          userCompany.canEditEntity(credit)
              ? EditIconButton(
                  isVisible: !credit.isDeleted,
                  onPressed: () => viewModel.onEditPressed(context),
                )
              : Container(),
          ActionMenuButton(
            entityActions: credit.getActions(userCompany: userCompany),
            isSaving: viewModel.isSaving,
            entity: credit,
            onSelected: viewModel.onEntityAction,
          )
        ],
      ),
      body: FormCard(children: [
        // STARTER: widgets - do not remove comment
      ]),
    );
  }
}
