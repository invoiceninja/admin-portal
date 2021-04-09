import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ClientPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      ClientFields.number,
      ClientFields.name,
      ClientFields.balance,
      ClientFields.paidToDate,
      ClientFields.contactName,
      ClientFields.contactEmail,
      ClientFields.lastLoginAt,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      ClientFields.address1,
      ClientFields.address2,
      ClientFields.country,
      ClientFields.idNumber,
      ClientFields.vatNumber,
      ClientFields.state,
      ClientFields.phone,
      ClientFields.website,
      ClientFields.language,
      ClientFields.currency,
      ClientFields.taskRate,
      ClientFields.publicNotes,
      ClientFields.privateNotes,
      ClientFields.creditBalance,
      ClientFields.custom1,
      ClientFields.custom2,
      ClientFields.custom3,
      ClientFields.custom4,
      ClientFields.documents,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final client = entity as ClientEntity;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    switch (field) {
      case ClientFields.name:
        return Text(client.displayName);
      case ClientFields.contactName:
        return Text(client.primaryContact.fullName);
      case ClientFields.contactEmail:
        return Text(client.primaryContact.email);
      case ClientFields.address1:
        return Text(client.address1);
      case ClientFields.address2:
        return Text(client.address2);
      case ClientFields.number:
        return Text(client.number);
      case ClientFields.idNumber:
        return Text(client.idNumber);
      case ClientFields.lastLoginAt:
        return Text(client.lastLogin == 0
            ? ''
            : formatDate(
                convertTimestampToDateString(client.lastLogin), context));
      case ClientFields.balance:
        return Align(
            alignment: Alignment.centerRight,
            child: Text(
                formatNumber(client.balance, context, clientId: client.id)));
      case ClientFields.creditBalance:
        return Align(
            alignment: Alignment.centerRight,
            child: Text(formatNumber(client.creditBalance, context,
                clientId: client.id)));
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
      case ClientFields.currency:
        return Text(
            state.staticState.currencyMap[client.currencyId]?.name ?? '');
      case ClientFields.vatNumber:
        return Text(client.vatNumber);
      case ClientFields.state:
        return Text(client.state);
      case ClientFields.phone:
        return Text(client.phone);
      case ClientFields.custom1:
        return Text(presentCustomField(client.customValue1));
      case ClientFields.custom2:
        return Text(presentCustomField(client.customValue2));
      case ClientFields.custom3:
        return Text(presentCustomField(client.customValue3));
      case ClientFields.custom4:
        return Text(presentCustomField(client.customValue4));
      case ClientFields.publicNotes:
        return Text(client.publicNotes);
      case ClientFields.privateNotes:
        return Text(client.privateNotes);
      case ClientFields.taskRate:
        return Text(formatNumber(client.settings.defaultTaskRate, context));
      case ClientFields.documents:
        return Text('${client.documents.length}');
    }

    return super.getField(field: field, context: context);
  }
}
