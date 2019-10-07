import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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
    final state = viewModel.state;
    final userCompany = state.userCompany;
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
            subtitle: memoizedClientStatsForGroup(state.clientState.map,
                group.id, localization.active, localization.archived),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
          SettingsViewer(
            settings: group.settings,
            state: state,
          )
        ],
      ),
    );
  }
}

class SettingsViewer extends StatelessWidget {
  const SettingsViewer({this.settings, this.state});

  final SettingsEntity settings;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final staticState = state.staticState;

    return FieldGrid({
      localization.name: settings.name,
      localization.address:
          settings.hasAddress ? formatAddress(object: settings) : null,
      localization.phone: settings.phone,
      localization.email: settings.email,
      localization.logo: settings.hasLogo ? localization.enabled : null,
      localization.idNumber: settings.idNumber,
      localization.vatNumber: settings.vatNumber,
      localization.website: settings.website,
      localization.timezone: settings.hasTimezone
          ? staticState.timezoneMap[settings.timezoneId]?.name
          : null,
      localization.dateFormat: settings.hasDateFormat
          ? staticState.dateFormatMap[settings.dateFormatId]?.format
          : null,
      localization.datetimeFormat: settings.hasDatetimeFormat
          ? staticState.datetimeFormatMap[settings.datetimeFormatId]?.format
          : null,
      localization.militaryTime:
          settings.enableMilitaryTime ? localization.enabled : null,
      localization.language: settings.hasLanguage
          ? staticState.languageMap[settings.languageId]?.name
          : null,
      localization.currency: settings.hasCurrency
          ? staticState.currencyMap[settings.currencyId]?.name
          : null,
      localization.sendReminders:
          settings.sendReminders ? localization.enabled : null,
      localization.showTasks:
          settings.showTasksInPortal ? localization.enabled : null,
      localization.paymentType: settings.hasDefaultPaymentTypeId
          ? staticState.paymentTypeMap[settings.defaultPaymentTypeId]?.name
          : null,
      localization.paymentTerms: settings.defaultPaymentTerms >= 0
          ? '${localization.net} ${settings.defaultPaymentTerms}'
          : null,
      localization.taskRate: settings.defaultTaskRate > 0
          ? formatNumber(settings.defaultTaskRate, context)
          : null,
    });
  }
}
