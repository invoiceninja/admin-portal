// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientViewLocations extends StatefulWidget {
  const ClientViewLocations({Key? key, this.viewModel}) : super(key: key);

  final ClientViewVM? viewModel;

  @override
  _ClientViewLocationsState createState() => _ClientViewLocationsState();
}

class _ClientViewLocationsState extends State<ClientViewLocations> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel!.client.isStale) {
      widget.viewModel!.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context)!;
    final client = widget.viewModel!.client;
    final locations = client.locations;

    if (client.isStale) {
      return LoadingIndicator();
    }

    return ScrollableListView(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppButton(
            label: localization.addLocation,
            onPressed: () {
              showDialog(context: context, builder: (_) => _LocationModal());
            }),
      ),
      SizedBox(height: 10),
      ...locations
          .map((location) => ListTile(
                //onTap: () => viewEntity(entity: entity as BaseEntity),
                title: Text(location.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (location.address1.isNotEmpty) Text(location.address1),
                    if (location.address2.isNotEmpty) Text(location.address2),
                    if (location.city.isNotEmpty ||
                        location.state.isNotEmpty ||
                        location.postalCode.isNotEmpty)
                      if (state.company.cityStateOrder() ==
                          CompanyFields.cityStatePostal)
                        Row(
                          children: [
                            if (location.city.isNotEmpty) Text(location.city),
                            if (location.city.isNotEmpty &&
                                location.state.isNotEmpty)
                              Text(', '),
                            if (location.state.isNotEmpty) Text(location.state),
                            if (location.city.isNotEmpty &&
                                location.state.isNotEmpty)
                              Text(' '),
                            if (location.postalCode.isNotEmpty)
                              Text(location.postalCode),
                          ],
                        )
                      else
                        Row(
                          children: [
                            if (location.postalCode.isNotEmpty)
                              Text(location.postalCode),
                            if (location.postalCode.isNotEmpty &&
                                location.city.isNotEmpty)
                              Text(' '),
                            if (location.city.isNotEmpty) Text(location.city),
                            if (location.city.isNotEmpty &&
                                location.state.isNotEmpty)
                              Text(', '),
                            if (location.state.isNotEmpty) Text(location.state),
                          ],
                        ),
                  ],
                ),
                leading: Icon(getEntityIcon(EntityType.location)),
              ))
          .toList(),
    ]);
  }
}

class _LocationModal extends StatefulWidget {
  const _LocationModal({this.location});

  final LocationEntity? location;

  @override
  State<_LocationModal> createState() => __LocationModalState();
}

class __LocationModalState extends State<_LocationModal> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return AlertDialog(
      title: Text(widget.location == null
          ? localization.addLocation
          : localization.editLocation),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localization.cancel.toUpperCase()),
        ),
      ],
    );
  }
}
