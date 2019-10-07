import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class GroupView extends StatefulWidget {
  const GroupView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final GroupViewVM viewModel;

  @override
  _GroupViewState createState() => new _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final userCompany = viewModel.state.userCompany;
    final group = viewModel.group;

    return Scaffold(
      appBar: AppBar(
        leading: !isMobile(context)
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: viewModel.onBackPressed,
              )
            : null,
        title: EntityStateTitle(entity: group),
        actions: [
          userCompany.canEditEntity(group)
              ? EditIconButton(
                  isVisible: !(group.isDeleted ?? false), // TODO remove this
                  onPressed: () => viewModel.onEditPressed(context),
                )
              : Container(),
          ActionMenuButton(
            entityActions: group.getActions(userCompany: userCompany),
            isSaving: viewModel.isSaving,
            entity: group,
            onSelected: viewModel.onEntityAction,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
          FieldGrid({
            GroupFields.custom1: group.customValue1,
            GroupFields.custom2: group.customValue2,
          }),
          EntityListTile(
            icon: getEntityIcon(EntityType.client),
            title: localization.clients,
            onTap: () => viewModel.onClientsPressed(context),
            onLongPress: () => viewModel.onClientsPressed(context, true),
            /*
            subtitle: memoizedPaymentStatsForClient(
                client.id,
                state.paymentState.map,
                state.invoiceState.map,
                localization.active,
                localization.archived),
             */
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        ],
      ),
    );
  }
}
