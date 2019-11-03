import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
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

  final List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
      _publicNotesController,
      _privateNotesController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final vendor = widget.viewModel.vendor;
    //_publicNotesController.text = vendor.publicNotes;
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
    _debouncer.run(() {
      final viewModel = widget.viewModel;
      final vendor = viewModel.vendor.rebuild((b) => b
        //..publicNotes = _publicNotesController.text
        ..privateNotes = _privateNotesController.text);
      if (vendor != viewModel.vendor) {
        viewModel.onChanged(vendor);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final staticState = viewModel.state.staticState;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            EntityDropdown(
              entityType: EntityType.currency,
              entityMap: staticState.currencyMap,
              entityList: memoizedCurrencyList(staticState.currencyMap),
              labelText: localization.currency,
              initialValue:
                  staticState.currencyMap[viewModel.vendor.currencyId]?.name,
              onSelected: (SelectableEntity currency) => viewModel.onChanged(
                  viewModel.vendor.rebuild((b) => b..currencyId = currency.id)),
            ),
            /*
            TextFormField(
              maxLines: 4,
              controller: _publicNotesController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: localization.publicNotes,
              ),
            ),
            */
            TextFormField(
              maxLines: 4,
              controller: _privateNotesController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: localization.privateNotes,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
