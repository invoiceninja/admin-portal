// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityHeader extends StatelessWidget {
  const EntityHeader({
    required this.entity,
    required this.label,
    required this.value,
    this.secondLabel,
    this.secondValue,
    this.statusLabel,
    this.statusColor,
  });

  final BaseEntity entity;
  final Color? statusColor;
  final String? statusLabel;
  final String? label;
  final String? value;
  final String? secondLabel;
  final String? secondValue;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    final store = StoreProvider.of<AppState>(context);
    final prefState = store.state.prefState;

    Widget _value1() {
      return CopyToClipboard(
        value: value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(label!,
                style: TextStyle(
                  fontSize: 16.0,
                  color: textColor!.withOpacity(.65),
                )),
            SizedBox(
              height: 8,
            ),
            FittedBox(
              child: Text(
                (value ?? '').isEmpty ? ' ' : value!,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _value2() {
      return CopyToClipboard(
        value: secondValue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(secondLabel!,
                style: TextStyle(
                  fontSize: 16.0,
                  color: textColor!.withOpacity(.65),
                )),
            SizedBox(
              height: 8,
            ),
            FittedBox(
              child: Text(
                (secondValue ?? '').isEmpty ? ' ' : secondValue!,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _value1()),
                if ((secondValue ?? '').isNotEmpty) ...[
                  SizedBox(width: 8),
                  Expanded(child: _value2()),
                ],
              ],
            ),
            Padding(
              padding: statusLabel != null || !entity.isActive
                  ? const EdgeInsets.only(top: 25)
                  : const EdgeInsets.all(0),
              child: Row(
                children: [
                  if (statusLabel != null)
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: EntityStatusChip(
                        entity: entity,
                        width: null,
                      ),
                    ),
                  if (!entity.isActive)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: entity.isArchived
                            ? Colors.orange
                            : prefState.colorThemeModel!.colorDanger,
                        borderRadius:
                            BorderRadius.all(Radius.circular(kBorderRadius)),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 120,
                          maxWidth: 120,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          child: Text(
                            entity.isArchived
                                ? localization!.archived
                                : localization!.deleted,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
