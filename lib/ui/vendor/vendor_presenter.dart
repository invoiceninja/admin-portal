import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class VendorPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      VendorFields.number,
      VendorFields.name,
      VendorFields.city,
      VendorFields.phone,
      EntityFields.state,
      EntityFields.createdAt,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      VendorFields.address1,
      VendorFields.address2,
      VendorFields.postalCode,
      VendorFields.countryId,
      VendorFields.privateNotes,
      VendorFields.website,
      VendorFields.vatNumber,
      VendorFields.idNumber,
      VendorFields.currencyId,
      VendorFields.customValue1,
      VendorFields.customValue2,
      VendorFields.customValue3,
      VendorFields.customValue4,
      VendorFields.updatedAt,
      VendorFields.archivedAt,
      VendorFields.documents,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final vendor = entity as VendorEntity;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    switch (field) {
      case VendorFields.name:
        return Text(vendor.name);
      case VendorFields.city:
        return Text(vendor.city);
      case VendorFields.phone:
        return Text(vendor.phone);
      case VendorFields.state:
        return Text(vendor.state);
      case VendorFields.address1:
        return Text(vendor.address1);
      case VendorFields.address2:
        return Text(vendor.address2);
      case VendorFields.idNumber:
        return Text(vendor.idNumber);
      case VendorFields.number:
        return Text(vendor.number);
      case VendorFields.postalCode:
        return Text(vendor.postalCode);
      case VendorFields.countryId:
        return Text(state.staticState.countryMap[vendor.countryId]?.name ?? '');
      case VendorFields.privateNotes:
        return Text(vendor.privateNotes);
      case VendorFields.website:
        return Text(vendor.website);
      case VendorFields.vatNumber:
        return Text(vendor.vatNumber);
      case VendorFields.currencyId:
        return Text(
            state.staticState.currencyMap[vendor.currencyId]?.name ?? '');
      case VendorFields.customValue1:
        return Text(presentCustomField(vendor.customValue1));
      case VendorFields.customValue2:
        return Text(presentCustomField(vendor.customValue2));
      case VendorFields.customValue3:
        return Text(presentCustomField(vendor.customValue3));
      case VendorFields.customValue4:
        return Text(presentCustomField(vendor.customValue4));
      case VendorFields.documents:
        return Text('${vendor.documents.length}');
    }

    return super.getField(field: field, context: context);
  }
}
