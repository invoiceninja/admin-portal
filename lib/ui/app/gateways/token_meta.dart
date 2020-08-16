import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/gateway_token_model.dart';

class TokenMeta extends StatelessWidget {
  const TokenMeta({this.meta});

  final GatewayTokenMetaEntity meta;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/payment_types/${meta.brand}.png',
          height: 16,
        ),
        SizedBox(width: 8),
        Text('•••• ${meta.last4} ${meta.expMonth}/${meta.expYear}'),
      ],
    );
  }
}
