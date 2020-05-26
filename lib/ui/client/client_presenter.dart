import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ClientPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      ClientFields.idNumber,
      ClientFields.name,
      ClientFields.balance,
      ClientFields.paidToDate,
      ClientFields.contact,
      ClientFields.contactEmail,
      EntityFields.createdAt,
      //ClientFields.contactLastLogin,
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
        return Align(
            alignment: Alignment.centerRight,
            child: Text(
                formatNumber(client.balance, context, clientId: client.id)));
      case ClientFields.paidToDate:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
              formatNumber(client.paidToDate, context, clientId: client.id)),
        );
    }

    return super.getField(field: field, context: context);
  }
}
