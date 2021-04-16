import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/document_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/settings/company_details.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CompanyDetailsScreen extends StatelessWidget {
  const CompanyDetailsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsCompanyDetails';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyDetailsVM>(
      converter: CompanyDetailsVM.fromStore,
      builder: (context, viewModel) {
        return CompanyDetails(
            key: ValueKey(viewModel.state.settingsUIState.updatedAt),
            viewModel: viewModel);
      },
    );
  }
}

class CompanyDetailsVM {
  CompanyDetailsVM({
    @required this.state,
    @required this.settings,
    @required this.company,
    @required this.onCompanyChanged,
    @required this.onSettingsChanged,
    @required this.onSavePressed,
    @required this.onUploadLogo,
    @required this.onDeleteLogo,
    @required this.onConfigurePaymentTermsPressed,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
  });

  static CompanyDetailsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return CompanyDetailsVM(
      state: state,
      settings: state.uiState.settingsUIState.settings,
      company: state.uiState.settingsUIState.company,
      onSettingsChanged: (settings) =>
          store.dispatch(UpdateSettings(settings: settings)),
      onCompanyChanged: (company) =>
          store.dispatch(UpdateCompany(company: company)),
      onDeleteLogo: (context) {
        final settingsUIState = state.uiState.settingsUIState;
        switch (settingsUIState.entityType) {
          case EntityType.company:
            final completer = snackBarCompleter<Null>(
                context, AppLocalization.of(context).deletedLogo);
            store.dispatch(SaveCompanyRequest(
              completer: completer,
              company: settingsUIState.company
                  .rebuild((b) => b..settings.companyLogo = null),
            ));
            break;
          case EntityType.group:
            final completer = snackBarCompleter<GroupEntity>(
                context, AppLocalization.of(context).deletedLogo);
            store.dispatch(SaveGroupRequest(
              completer: completer,
              group: settingsUIState.group
                  .rebuild((b) => b..settings.companyLogo = null),
            ));
            break;
          case EntityType.client:
            final completer = snackBarCompleter<ClientEntity>(
                context, AppLocalization.of(context).deletedLogo);
            store.dispatch(SaveClientRequest(
              completer: completer,
              client: settingsUIState.client
                  .rebuild((b) => b..settings.companyLogo = null),
            ));
            break;
        }
      },
      onSavePressed: (context) {
        Debouncer.runOnComplete(() {
          final settingsUIState = store.state.uiState.settingsUIState;
          if (settingsUIState.entityType == EntityType.company &&
              settingsUIState.company.settings.countryId == null) {
            showErrorDialog(
                context: context,
                message: AppLocalization.of(context).pleaseSelectACountry);
            return;
          }
          switch (settingsUIState.entityType) {
            case EntityType.company:
              final completer = snackBarCompleter<Null>(
                  context, AppLocalization.of(context).savedSettings);
              store.dispatch(SaveCompanyRequest(
                  completer: completer, company: settingsUIState.company));
              break;
            case EntityType.group:
              final completer = snackBarCompleter<GroupEntity>(
                  context, AppLocalization.of(context).savedSettings);
              store.dispatch(SaveGroupRequest(
                  completer: completer, group: settingsUIState.group));
              break;
            case EntityType.client:
              final completer = snackBarCompleter<ClientEntity>(
                  context, AppLocalization.of(context).savedSettings);
              store.dispatch(SaveClientRequest(
                  completer: completer, client: settingsUIState.client));
              break;
          }
        });
      },
      onUploadLogo: (context, multipartFile) {
        final type = state.uiState.settingsUIState.entityType;
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).uploadedLogo);
        store.dispatch(UploadLogoRequest(
            completer: completer, multipartFile: multipartFile, type: type));
      },
      onConfigurePaymentTermsPressed: (context) {
        if (state.paymentTermState.list.isEmpty) {
          store.dispatch(ViewSettings(section: kSettingsPaymentTermEdit));
        } else {
          store.dispatch(ViewSettings(section: kSettingsPaymentTerms));
        }
      },
      onUploadDocument: (BuildContext context, MultipartFile multipartFile) {
        final Completer<DocumentEntity> completer = Completer<DocumentEntity>();
        store.dispatch(SaveCompanyDocumentRequest(
            multipartFile: multipartFile, completer: completer));
        completer.future.then((client) {
          showToast(AppLocalization.of(context).uploadedDocument);
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
      onDeleteDocument: (BuildContext context, DocumentEntity document,
          String password, String idToken) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).deletedDocument);
        completer.future.then<Null>((value) => store.dispatch(RefreshData()));
        store.dispatch(DeleteDocumentRequest(
          completer: completer,
          documentIds: [document.id],
          password: password,
          idToken: idToken,
        ));
      },
    );
  }

  final AppState state;
  final CompanyEntity company;
  final SettingsEntity settings;
  final Function(SettingsEntity) onSettingsChanged;
  final Function(CompanyEntity) onCompanyChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext, MultipartFile) onUploadLogo;
  final Function(BuildContext) onDeleteLogo;
  final Function(BuildContext) onConfigurePaymentTermsPressed;
  final Function(BuildContext, MultipartFile) onUploadDocument;
  final Function(BuildContext, DocumentEntity, String, String) onDeleteDocument;
}
