// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class WebhookListItem extends StatelessWidget {
  const WebhookListItem({
    required this.user,
    required this.webhook,
    required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity? user;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final WebhookEntity webhook;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final webhookUIState = uiState.webhookUIState;
    final listUIState = webhookUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final filterMatch = filter != null && filter!.isNotEmpty
        ? webhook.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: webhook,
      isSelected: webhook.id ==
          (uiState.isEditing
              ? webhookUIState.editing!.id
              : webhookUIState.selectedId),
      child: ListTile(
        onTap: () => onTap != null ? onTap!() : selectEntity(entity: webhook),
        onLongPress: () => onLongPress != null
            ? onLongPress!()
            : selectEntity(entity: webhook, longPress: true),
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
                  webhook.targetUrl,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(formatNumber(webhook.listDisplayAmount, context)!,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(localization.lookup(webhook.eventType)),
            subtitle != null && subtitle.isNotEmpty
                ? Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
            EntityStateLabel(webhook),
          ],
        ),
      ),
    );
  }
}
