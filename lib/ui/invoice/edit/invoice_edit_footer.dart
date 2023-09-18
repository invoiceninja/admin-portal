// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class InvoiceEditFooter extends StatelessWidget {
  const InvoiceEditFooter({required this.invoice});

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final total = formatNumber(
      invoice.calculateTotal(precision: precisionForInvoice(state, invoice)),
      context,
      clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
      vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
    );
    final useSidebarEditor =
        state.prefState.useSidebarEditor[EntityType.invoice] ?? false;
    final showLayoutToggle = isDesktop(context);
    final title =
        '${localization.lookup('${invoice.entityType!.snakeCase}_total')} $total';

    return BottomAppBar(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: CircularNotchedRectangle(),
      child: SizedBox(
        height: kTopBottomBarHeight,
        child: AppBorder(
          isTop: true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showLayoutToggle)
                Tooltip(
                  message: useSidebarEditor
                      ? localization.fullscreenEditor
                      : localization.sidebarEditor,
                  child: InkWell(
                    onTap: () =>
                        store.dispatch(ToggleEditorLayout(EntityType.invoice)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(useSidebarEditor
                          ? Icons.chevron_left
                          : Icons.chevron_right),
                    ),
                  ),
                ),
              AppBorder(
                isLeft: showLayoutToggle,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    invoice.number.isEmpty
                        ? title
                        : '${invoice.number} • $title',
                    style: TextStyle(
                      color: state.prefState.enableDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
