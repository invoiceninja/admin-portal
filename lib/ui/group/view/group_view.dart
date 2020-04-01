import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class GroupView extends StatefulWidget {
  const GroupView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final GroupViewVM viewModel;

  @override
  _GroupViewState createState() => new _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final group = viewModel.group;

    return ViewScaffold(
      entity: group,
      isSettings: true,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              label: localization.configureSettings.toUpperCase(),
              iconData: Icons.settings,
              onPressed: () =>
                  handleGroupAction(context, [group], EntityAction.settings),
            ),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
          EntityListTile(
            icon: getEntityIcon(EntityType.client),
            title: localization.clients,
            onTap: () => viewModel.onClientsPressed(context),
            onLongPress: () => viewModel.onClientsPressed(context, true),
            subtitle:
                memoizedClientStatsForGroup(state.clientState.map, group.id)
                    .present(localization.active, localization.archived),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
          SettingsViewer(
            settings: group.settings,
            state: state,
          )
        ],
      ),
    );
  }
}

class SettingsViewer extends StatelessWidget {
  const SettingsViewer({this.settings, this.state});

  final SettingsEntity settings;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final staticState = state.staticState;

    return FieldGrid({
      localization.name: settings.name,
      localization.address:
          settings.hasAddress ? formatAddress(object: settings) : null,
      localization.phone: settings.phone,
      localization.email: settings.email,
      localization.logo: settings.hasLogo ? localization.enabled : null,
      localization.idNumber: settings.idNumber,
      localization.vatNumber: settings.vatNumber,
      localization.website: settings.website,
      localization.address1: settings.address1,
      localization.address2: settings.address2,
      localization.city: settings.city,
      localization.state: settings.state,
      localization.country: settings.countryId != null
          ? state.staticState.countryMap[settings.countryId]?.name
          : null,
      localization.postalCode: settings.postalCode,
      localization.pageSize: settings.pageSize,
      localization.fontSize: settings.fontSize?.toString(),
      localization.primaryColor: settings.primaryColor,
      localization.secondaryColor: settings.secondaryColor,
      localization.primaryFont: settings.primaryFont,
      localization.secondaryFont: settings.secondaryFont,
      localization.hidePaidToDate: settings.hidePaidToDate?.toString(),
      localization.invoiceEmbedDocuments: settings.embedDocuments?.toString(),
      localization.timezone: settings.hasTimezone
          ? staticState.timezoneMap[settings.timezoneId]?.name
          : null,
      localization.dateFormat: settings.hasDateFormat
          ? staticState.dateFormatMap[settings.dateFormatId]?.format
          : null,
      localization.militaryTime: settings.enableMilitaryTime == true
          ? localization.enabled
          : settings.enableMilitaryTime == false ? localization.disabled : null,
      localization.language: settings.hasLanguage
          ? staticState.languageMap[settings.languageId]?.name
          : null,
      localization.currency: settings.hasCurrency
          ? staticState.currencyMap[settings.currencyId]?.name
          : null,
      localization.sendReminders: settings.sendReminders == true
          ? localization.enabled
          : settings.sendReminders == false ? localization.disabled : null,
      localization.clientPortal: settings.enablePortal == true
          ? localization.enabled
          : settings.enablePortal == false ? localization.disabled : null,
      localization.clientPortalTasks: settings.enablePortal == true
          ? localization.enabled
          : settings.enablePortal == false ? localization.disabled : null,
      localization.clientPortalDashboard: settings.enablePortal == true
          ? localization.enabled
          : settings.enablePortal == false ? localization.disabled : null,
      localization.paymentType: settings.hasDefaultPaymentTypeId
          ? staticState.paymentTypeMap[settings.defaultPaymentTypeId]?.name
          : null,
      localization.invoiceFields: settings.invoiceFields,
      localization.emailSignature: settings.emailFooter,
      localization.emailStyle: settings.emailStyle,
      localization.replyToEmail: settings.replyToEmail,
      localization.bccEmail: settings.bccEmail,
      localization.customValue1: settings.customValue1,
      localization.customValue2: settings.customValue2,
      localization.customValue3: settings.customValue3,
      localization.customValue4: settings.customValue4,
      //localization.paymentTerms: settings.defaultPaymentTerms,
      localization.paymentTerms: settings.companyGatewayIds != null
          ? state.companyGatewayState.map[settings.companyGatewayIds]
              ?.listDisplayName
          : null,
      localization.taskRate: settings.defaultTaskRate?.toString(),
      localization.attachPdf: settings.pdfEmailAttachment?.toString(),
      localization.attachUbl: settings.ublEmailAttachment?.toString(),
      localization.attachDocuments:
          settings.documentEmailAttachment?.toString(),
      localization.attachDocuments:
          settings.documentEmailAttachment?.toString(),
      localization.emailStyleCustom: settings.emailStyleCustom?.toString(),
      localization.emailSubjectInvoice:
          settings.emailSubjectInvoice?.toString(),
      localization.emailSubjectQuote: settings.emailSubjectQuote?.toString(),
      localization.emailSubjectPayment: settings.emailSubjectPayment,
      localization.emailSubjectPaymentPartial:
          settings.emailSubjectPaymentPartial,
      //localization.emailBodyInvoice:
      //    settings.emailBodyInvoice?.toString(),
      //localization.emailBodyQuote:
      //    settings.emailBodyQuote?.toString(),
      //localization.emailBodyPayment:
      //    settings.emailBodyPayment?.toString(),
      //localization.emailBodyPaymentPartial:
      //    settings.emailBodyPaymentPartial?.toString(),
      //localization.emailSubjectReminder1:
      //    settings.emailSubjectReminder1?.toString(),
      //localization.emailSubjectReminder2:
      //    settings.emailSubjectReminder2?.toString(),
      //localization.emailSubjectReminder3:
      //    settings.emailSubjectReminder3?.toString(),
      //localization.emailSubjectReminder4:
      //    settings.emailSubjectReminder4?.toString(),
      //localization.emailBodyReminder1:
      //    settings.emailBodyReminder1?.toString(),
      //localization.emailBodyReminder2:
      //    settings.emailBodyReminder2?.toString(),
      //localization.emailBodyReminder3:
      //    settings.emailBodyReminder3?.toString(),
      //localization.emailBodyReminder4:
      //    settings.emailBodyReminder4?.toString(),
      localization.customMessageDashboard:
          settings.customMessageDashboard?.toString(),
      localization.customMessageUnpaidInvoice:
          settings.customMessageUnpaidInvoice?.toString(),
      localization.customMessagePaidInvoice:
          settings.customMessagePaidInvoice?.toString(),
      localization.customMessageUnapprovedQuote:
          settings.customMessageUnapprovedQuote?.toString(),
      localization.lockSentInvoices: settings.lockSentInvoices?.toString(),
      localization.autoArchiveInvoice: settings.autoArchiveInvoice?.toString(),
      localization.autoArchiveQuote: settings.autoArchiveQuote?.toString(),
      localization.autoEmailInvoice: settings.autoEmailInvoice?.toString(),
      localization.autoConvertQuote: settings.autoConvertQuote?.toString(),
      localization.inclusiveTaxes: settings.enableInclusiveTaxes?.toString(),
      localization.translations: settings.translations?.keys?.join(', '),
      localization.taskNumberPattern: settings.taskNumberPattern,
      localization.taskNumberCounter: settings.taskNumberCounter?.toString(),
      localization.expenseNumberPattern: settings.expenseNumberPattern,
      localization.expenseNumberCounter:
          settings.expenseNumberCounter?.toString(),
      localization.vendorNumberPattern: settings.vendorNumberPattern,
      localization.vendorNumberCounter:
          settings.vendorNumberCounter?.toString(),
      localization.ticketNumberPattern: settings.ticketNumberPattern,
      localization.ticketNumberCounter:
          settings.ticketNumberCounter?.toString(),
      localization.paymentNumberPattern: settings.paymentNumberPattern,
      localization.paymentNumberCounter:
          settings.paymentNumberCounter?.toString(),
      localization.invoiceNumberPattern: settings.invoiceNumberPattern,
      localization.invoiceNumberCounter:
          settings.invoiceNumberCounter?.toString(),
      localization.quoteNumberPattern: settings.quoteNumberPattern,
      localization.quoteNumberCounter: settings.quoteNumberCounter?.toString(),
      localization.clientNumberPattern: settings.clientNumberPattern,
      localization.clientNumberCounter:
          settings.clientNumberCounter?.toString(),
      localization.creditNumberPattern: settings.creditNumberPattern,
      localization.creditNumberCounter:
          settings.creditNumberCounter?.toString(),
      localization.recurringPrefix: settings.recurringNumberPrefix?.toString(),
      localization.resetCounter: settings.resetCounterFrequencyId?.toString(),
      localization.resetCounterDate: settings.resetCounterDate?.toString(),
      localization.counterPadding: settings.counterPadding?.toString(),
      localization.sharedInvoiceQuoteCounter:
          settings.sharedInvoiceQuoteCounter?.toString(),
      localization.invoiceTerms: settings.defaultInvoiceTerms,
      localization.quoteTerms: settings.defaultQuoteTerms,
      localization.quoteFooter: settings.defaultQuoteFooter,
      localization.creditTerms: settings.defaultCreditTerms,
      localization.creditFooter: settings.defaultCreditFooter,
      localization.invoiceTaxRates:
          settings.numberOfInvoiceTaxRates?.toString(),
      localization.itemTaxRates: settings.numberOfItemTaxRates?.toString(),
      //localization.defaultInvoiceDesignId: settings.defaultInvoiceDesignId,
      //localization.defaultQuoteDesignId: settings.defaultQuoteDesignId,
      //localization.defaultCreditDesignId: settings.defaultCreditDesignId,
      localization.invoiceFooter: settings.defaultInvoiceFooter?.toString(),
      localization.invoiceLabels: settings.invoiceLabels?.toString(),
      localization.defaultTaxName1: settings.defaultTaxName1?.toString(),
      localization.defaultTaxRate1: settings.defaultTaxRate1?.toString(),
      localization.defaultTaxName2: settings.defaultTaxName2?.toString(),
      localization.defaultTaxRate2: settings.defaultTaxRate2?.toString(),
      localization.defaultTaxName3: settings.defaultTaxName3?.toString(),
      localization.defaultTaxRate3: settings.defaultTaxRate3?.toString(),
      //localization.defaultPaymentTypeId: settings.defaultPaymentTypeId,
      localization.enablePortalPassword:
          settings.enablePortalPassword?.toString(),
      localization.signatureOnPdf: settings.signatureOnPdf?.toString(),
      localization.enableMarkup: settings.enableEmailMarkup?.toString(),
      localization.showAcceptInvoiceTerms:
          settings.showAcceptInvoiceTerms?.toString(),
      localization.showAcceptQuoteTerms:
          settings.showAcceptQuoteTerms?.toString(),
      localization.requireInvoiceSignature:
          settings.requireInvoiceSignature?.toString(),
      localization.requireQuoteSignature:
          settings.requireQuoteSignature?.toString(),
      localization.allPagesHeader: settings.allPagesHeader?.toString(),
      localization.allPagesFooter: settings.allPagesFooter?.toString(),
      //localization.enableReminder1: settings.enableReminder1,
      //localization.enableReminder2: settings.enableReminder2,
      //localization.enableReminder3: settings.enableReminder3,
      //localization.enableReminder4: settings.enableReminder4,
      //localization.numDaysReminder1: settings.numDaysReminder1,
      //localization.numDaysReminder2: settings.numDaysReminder2,
      //localization.numDaysReminder3: settings.numDaysReminder3,
      //localization.scheduleReminder1: settings.scheduleReminder1,
      //localization.scheduleReminder2: settings.scheduleReminder2,
      //localization.scheduleReminder3: settings.scheduleReminder3,
      //localization.endlessReminderFrequencyId: settings.endlessReminderFrequencyId,
      //localization.lateFeeAmount1: settings.lateFeeAmount1,
      //localization.lateFeeAmount2: settings.lateFeeAmount2,
      //localization.lateFeeAmount3: settings.lateFeeAmount3,
      //localization.lateFeePercent1: settings.lateFeePercent1,
      //localization.lateFeePercent2: settings.lateFeePercent2,
      //localization.lateFeePercent3: settings.lateFeePercent3,
    });
  }
}
