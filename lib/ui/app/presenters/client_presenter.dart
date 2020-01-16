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
      //ClientFields.lastLogin, // TODO implement
      ClientFields.balance,
      EntityFields.state,
    ];
  }

  @override
  String getField({String field, BuildContext context}) {
    final client = entity as ClientEntity;

    switch (field) {
      case ClientFields.name:
        return client.name;
      case ClientFields.contact:
        return client.primaryContact.fullName;
      case ClientFields.contactEmail:
        return client.primaryContact.email;
      case ClientFields.address1:
        return client.address1;
      case ClientFields.idNumber:
        return client.idNumber;
      case ClientFields.balance:
        return formatNumber(client.balance, context);
    }

    return super.getField(field: field, context: context);
  }
}
