// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';

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
    final client = widget.viewModel!.client;
    final locations = client.locations;

    if (client.isStale) {
      return LoadingIndicator();
    }

    return ScrollableListViewBuilder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: locations.length,
      separatorBuilder: (context, index) => ListDivider(),
      itemBuilder: (BuildContext context, index) {
        final store = StoreProvider.of<AppState>(context);
        final state = store.state;

        final location = locations[index];

        return ListTile(
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
                      if (location.city.isNotEmpty && location.state.isNotEmpty)
                        Text(', '),
                      if (location.state.isNotEmpty) Text(location.state),
                      if (location.city.isNotEmpty && location.state.isNotEmpty)
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
                      if (location.city.isNotEmpty && location.state.isNotEmpty)
                        Text(', '),
                      if (location.state.isNotEmpty) Text(location.state),
                    ],
                  ),
            ],
          ),
          leading: Icon(getEntityIcon(EntityType.location)),
        );
      },
    );
  }
}
