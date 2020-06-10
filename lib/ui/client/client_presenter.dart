import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ClientPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      ClientFields.idNumber,
      ClientFields.name,
      ClientFields.balance,
      ClientFields.paidToDate,
      ClientFields.contact,
      ClientFields.contactEmail,
      EntityFields.createdAt,
      //ClientFields.contactLastLogin, // TODO implement field
      EntityFields.state,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ClientFields.address1,
      ClientFields.address2,
      ClientFields.country,
      ClientFields.vatNumber,
      EntityFields.updatedAt,
      EntityFields.archivedAt,
      ClientFields.vatNumber,
      ClientFields.state,
      ClientFields.phone,
      ClientFields.website,
      ClientFields.language,
      ClientFields.currency,
      ClientFields.custom1,
      ClientFields.custom2,
      ClientFields.custom3,
      ClientFields.custom4,
      ClientFields.assignedTo,
      ClientFields.createdBy,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
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
      case ClientFields.address2:
        return Text(client.address2);
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
      case ClientFields.country:
        return Text(state.staticState.countryMap[client.countryId]?.name ?? '');
      case ClientFields.language:
        return Text(
            state.staticState.languageMap[client.languageId]?.name ?? '');
      case ClientFields.vatNumber:
        return Text(client.vatNumber);
    }

    return super.getField(field: field, context: context);
  }
}

/*
EntityFields.updatedAt,
EntityFields.archivedAt,
ClientFields.vatNumber,
ClientFields.state,
ClientFields.phone,
ClientFields.website,
ClientFields.currency,
ClientFields.custom1,
ClientFields.custom2,
ClientFields.custom3,
ClientFields.custom4,
ClientFields.assignedTo,
ClientFields.createdBy,
*/
