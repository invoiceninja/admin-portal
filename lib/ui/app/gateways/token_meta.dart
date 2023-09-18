// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/gateway_token_model.dart';

class TokenMeta extends StatelessWidget {
  const TokenMeta({this.meta});

  final GatewayTokenMetaEntity? meta;

  @override
  Widget build(BuildContext context) {
    var cardDetails = '••••';

    if (meta!.last4 != null) {
      cardDetails += ' ${meta!.last4}';
    }

    if (meta!.expMonth != null && meta!.expYear != null) {
      cardDetails += '  ${meta!.expMonth}/${meta!.expYear}';
    }

    return Row(
      children: [
        Image.asset(
          'assets/images/payment_types/${meta!.brand}.png',
          height: 16,
        ),
        SizedBox(width: 8),
        Flexible(
          child: Text(
            cardDetails,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
