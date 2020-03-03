import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';

class DesignView extends StatefulWidget {
  const DesignView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DesignViewVM viewModel;

  @override
  _DesignViewState createState() => new _DesignViewState();
}

class _DesignViewState extends State<DesignView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final userCompany = viewModel.state.userCompany;
    final design = viewModel.design;

    return Scaffold(
      appBar: AppBar(
        title: EntityStateTitle(entity: design),
        actions: [
          userCompany.canEditEntity(design)
              ? EditIconButton(
                  isVisible: !design.isDeleted,
                  onPressed: () => viewModel.onEditPressed(context),
                )
              : Container(),
          ActionMenuButton(
            entityActions: design.getActions(userCompany: userCompany),
            isSaving: viewModel.isSaving,
            entity: design,
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
