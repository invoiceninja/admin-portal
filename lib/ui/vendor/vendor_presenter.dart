import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class VendorPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      VendorFields.name,
      VendorFields.city,
      VendorFields.phone,
      EntityFields.state,
      EntityFields.createdAt,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final vendor = entity as VendorEntity;

    switch (field) {
      case VendorFields.name:
        return Text(vendor.name);
      case VendorFields.city:
        return Text(vendor.city);
      case VendorFields.phone:
        return Text(vendor.phone);
      case VendorFields.state:
        return Text(vendor.state);
    }

    return super.getField(field: field, context: context);
  }
}
