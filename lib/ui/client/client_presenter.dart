import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ClientPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      ClientFields.name,
      ClientFields.contact,
      ClientFields.contactEmail,
      ClientFields.idNumber,
      EntityFields.createdAt,
      //ClientFields.contactLastLogin,
      ClientFields.balance,
      EntityFields.state,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final client = entity as ClientEntity;

    switch (field) {
      case ClientFields.name:
        return Text(client.name);
      case ClientFields.contact:
        return Text(client.primaryContact.fullName);
      case ClientFields.contactEmail:
        return Text(client.primaryContact.email);
      case ClientFields.address1:
        return Text(client.address1);
      case ClientFields.idNumber:
        return Text(client.idNumber);
      case ClientFields.balance:
        return Text(formatNumber(client.balance, context));
    }

    return super.getField(field: field, context: context);
  }
}
