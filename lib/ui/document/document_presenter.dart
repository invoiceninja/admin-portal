// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DocumentPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [
      DocumentFields.name,
      DocumentFields.linkedTo,
      DocumentFields.size,
      DocumentFields.width,
      DocumentFields.height,
      DocumentFields.isPrivate,
      DocumentFields.createdAt,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      DocumentFields.id,
      DocumentFields.type,
      DocumentFields.hash,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);
    final document = entity as DocumentEntity?;

    switch (field) {
      case DocumentFields.name:
        return Text(document!.name);
      case DocumentFields.createdAt:
        return Text(formatDate(
            convertTimestampToDateString(entity.createdAt), context,
            showTime: true));
      case DocumentFields.type:
        return Text(document!.type);
      case DocumentFields.size:
        return Text(document!.prettySize);
      case DocumentFields.width:
        return Text(document!.width > 0 ? '${document.width}' : '');
      case DocumentFields.height:
        return Text(document!.height > 0 ? '${document.height}' : '');
      case DocumentFields.id:
        return Text(document!.id);
      case DocumentFields.hash:
        return Text(document!.hash);
      case DocumentFields.linkedTo:
        final parentEntity =
            state.getEntity(document!.parentType, document.parentId);
        return LinkTextRelatedEntity(entity: parentEntity, relation: document);
      case DocumentFields.isPrivate:
        return Text(document!.isPublic ? localization!.no : localization!.yes);
    }

    return super.getField(field: field, context: context);
  }
}
