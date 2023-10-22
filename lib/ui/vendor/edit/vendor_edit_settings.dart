// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorEditSettings extends StatefulWidget {
  const VendorEditSettings({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final VendorEditVM viewModel;

  @override
  VendorEditSettingsState createState() => new VendorEditSettingsState();
}

class VendorEditSettingsState extends State<VendorEditSettings> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final vendor = viewModel.vendor;
    final isFullscreen = state.prefState.isEditorFullScreen(EntityType.vendor);

    return FormCard(
      isLast: true,
      padding: isFullscreen
          ? const EdgeInsets.only(
              left: kMobileDialogPadding / 2,
              top: kMobileDialogPadding,
              right: kMobileDialogPadding / 2,
            )
          : null,
      children: <Widget>[
        EntityDropdown(
          entityType: EntityType.currency,
          entityList: memoizedCurrencyList(state.staticState.currencyMap),
          labelText: localization.currency,
          entityId: vendor.currencyId,
          onSelected: (SelectableEntity? currency) => viewModel.onChanged(
              vendor.rebuild((b) => b..currencyId = currency?.id ?? '')),
        ),
        EntityDropdown(
          entityType: EntityType.language,
          entityList: memoizedLanguageList(state.staticState.languageMap),
          labelText: localization.language,
          entityId: vendor.languageId,
          onSelected: (SelectableEntity? language) => viewModel.onChanged(
              vendor.rebuild((b) => b..languageId = language?.id ?? '')),
        ),
      ],
    );
  }
}
