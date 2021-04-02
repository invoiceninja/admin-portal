import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';

class VendorEditNotes extends StatefulWidget {
  const VendorEditNotes({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorEditVM viewModel;

  @override
  VendorEditNotesState createState() => new VendorEditNotesState();
}

class VendorEditNotesState extends State<VendorEditNotes> {
  final _publicNotesController = TextEditingController();
  final _privateNotesController = TextEditingController();

  List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _publicNotesController,
      _privateNotesController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final vendor = widget.viewModel.vendor;
    _publicNotesController.text = vendor.publicNotes;
    _privateNotesController.text = vendor.privateNotes;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final vendor = viewModel.vendor.rebuild((b) => b
      ..publicNotes = _publicNotesController.text
      ..privateNotes = _privateNotesController.text);
    if (vendor != viewModel.vendor) {
      _debouncer.run(() {
        viewModel.onChanged(vendor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final staticState = viewModel.state.staticState;
    final vendor = viewModel.vendor;

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            EntityDropdown(
              key: ValueKey('__currency_${vendor.currencyId}__'),
              entityType: EntityType.currency,
              entityList: memoizedCurrencyList(staticState.currencyMap),
              labelText: localization.currency,
              entityId: vendor.currencyId,
              onSelected: (SelectableEntity currency) => viewModel.onChanged(
                  vendor.rebuild((b) => b..currencyId = currency?.id ?? '')),
            ),
            DecoratedFormField(
              maxLines: 4,
              controller: _publicNotesController,
              keyboardType: TextInputType.multiline,
              label: localization.publicNotes,
            ),
            DecoratedFormField(
              maxLines: 4,
              controller: _privateNotesController,
              keyboardType: TextInputType.multiline,
              label: localization.privateNotes,
            ),
          ],
        ),
      ],
    );
  }
}
