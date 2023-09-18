// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/gateway_token_model.dart';
import 'package:invoiceninja_flutter/ui/app/gateways/token_meta.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientViewPaymentMethods extends StatelessWidget {
  const ClientViewPaymentMethods({
    Key? key,
    required this.viewModel,
    required this.tokenMap,
    required this.gatewayMap,
    required this.linkMap,
  }) : super(key: key);

  final ClientViewVM viewModel;
  final Map<String, List<GatewayTokenEntity>> tokenMap;
  final Map<String, CompanyGatewayEntity> gatewayMap;
  final Map<String, String> linkMap;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final customerReferences = tokenMap.keys.toList();

    return ScrollableListViewBuilder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: customerReferences.length,
        separatorBuilder: (context, index) => ListDivider(),
        itemBuilder: (BuildContext context, index) {
          final customerReference = customerReferences[index];
          return ListTile(
            title: Text(
                '${localization!.gateway}  ›  ${gatewayMap[customerReference]!.label}'),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              children: tokenMap[customerReference]!
                  .map((token) => TokenMeta(
                        meta: token.meta,
                      ))
                  .toList(),
            ),
            onTap: linkMap.containsKey(customerReference)
                ? () => launchUrl(Uri.parse(linkMap[customerReference]!))
                : null,
            leading: IgnorePointer(
              child: IconButton(
                icon: Icon(Icons.payment),
                onPressed: () => null,
              ),
            ),
            trailing: linkMap.containsKey(customerReference)
                ? IgnorePointer(
                    child: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () => null,
                    ),
                  )
                : null,
          );
        });
  }
}
