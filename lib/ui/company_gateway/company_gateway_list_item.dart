// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyGatewayListItem extends StatelessWidget {
  const CompanyGatewayListItem({
    Key? key,
    required this.user,
    required this.companyGateway,
    required this.filter,
    this.onRemovePressed,
    this.onCheckboxChanged,
    this.isChecked = false,
  }) : super(key: key);

  final UserEntity? user;
  final CompanyGatewayEntity? companyGateway;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final Function? onRemovePressed;
  final bool isChecked;

  static final companyGatewayItemKey =
      (int id) => Key('__company_gateway_item_${id}__');

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter!.isNotEmpty
        ? companyGateway!.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;
    final listUIState = state.uiState.companyGatewayUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final child = ListTile(
      onTap: () => selectEntity(entity: companyGateway!),
      trailing: onRemovePressed == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(right: 16),
              child: AppTextButton(
                label: AppLocalization.of(context)!.remove,
                onPressed: onRemovePressed,
              ),
            ),
      leading: showCheckbox
          ? IgnorePointer(
              ignoring: listUIState.isInMultiselect(),
              child: Checkbox(
                value: isChecked,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (value) => onCheckboxChanged!(value),
                activeColor: Theme.of(context).colorScheme.secondary,
              ),
            )
          : null,
      title: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                companyGateway!.listDisplayName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(formatNumber(companyGateway!.listDisplayAmount, context)!,
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (companyGateway!.isTestMode) Text(localization!.testMode),
          subtitle != null && subtitle.isNotEmpty
              ? Text(
                  subtitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              : Container(),
          EntityStateLabel(companyGateway),
        ],
      ),
    );

    return child;

    /*
    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: companyGateway,
      isSelected: false,
      child: child,
    );
    */
  }
}
