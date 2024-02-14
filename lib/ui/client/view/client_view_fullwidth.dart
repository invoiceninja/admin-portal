import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/gateway_token_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_tab_bar.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/portal_links.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_activity.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_documents.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_ledger.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_payment_methods.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_system_logs.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientViewFullwidth extends StatefulWidget {
  const ClientViewFullwidth({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ClientViewVM viewModel;

  @override
  State<ClientViewFullwidth> createState() => _ClientViewFullwidthState();
}

class _ClientViewFullwidthState extends State<ClientViewFullwidth>
    with TickerProviderStateMixin {
  ScrollController? _scrollController1;
  ScrollController? _scrollController2;
  ScrollController? _scrollController3;

  @override
  void initState() {
    super.initState();

    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();
  }

  @override
  void dispose() {
    _scrollController1!.dispose();
    _scrollController2!.dispose();
    _scrollController3!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final client = state.clientState.get(state.uiState.filterEntityId!);
    final documents = client.documents;
    final viewModel = widget.viewModel;
    final billingAddress = formatAddress(state, object: client);
    final shippingAddress =
        formatAddress(state, object: client, isShipping: true);

    final hasMultipleContacts = client.contacts.length > 1;

    final showStanding = !state.prefState.isPreviewVisible &&
        !state.uiState.isEditing &&
        state.prefState.isModuleTable;

    // Group gateway tokens by the customerReference
    final tokenMap = <String, List<GatewayTokenEntity>>{};
    final gatewayMap = <String, CompanyGatewayEntity>{};
    final linkMap = <String, String>{};

    client.gatewayTokens.forEach((gatewayToken) {
      final companyGateway =
          state.companyGatewayState.get(gatewayToken.companyGatewayId);
      if (companyGateway.isOld && !companyGateway.isDeleted!) {
        final customerReference = gatewayToken.customerReference;
        gatewayMap[customerReference] = companyGateway;
        final clientUrl = GatewayEntity.getClientUrl(
          gatewayId: companyGateway.gatewayId,
          customerReference: customerReference,
        );
        if (clientUrl != null) {
          linkMap[customerReference] = clientUrl;
        }
        if (tokenMap.containsKey(customerReference)) {
          tokenMap[customerReference]!.add(gatewayToken);
        } else {
          tokenMap[customerReference] = [gatewayToken];
        }
      }
    });

    return LayoutBuilder(builder: (context, layout) {
      final minHeight = layout.maxHeight - (kMobileDialogPadding * 2) - 43;
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FormCard(
              isLast: true,
              constraints: BoxConstraints(minHeight: minHeight),
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: const EdgeInsets.only(
                  top: kMobileDialogPadding,
                  right: kMobileDialogPadding / 2,
                  bottom: kMobileDialogPadding,
                  left: kMobileDialogPadding),
              child: ListView(
                controller: _scrollController1,
                children: [
                  Text(
                    localization!.details,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  if (client.isTaxExempt) Text(localization.isTaxExempt),
                  if (client.paymentBalance != 0)
                    Text(localization.payments +
                        ': ' +
                        formatNumber(client.paymentBalance, context,
                            clientId: client.id)!),
                  if (client.creditBalance != 0)
                    Text(localization.credit +
                        ': ' +
                        formatNumber(client.creditBalance, context,
                            clientId: client.id)!),
                  if (client.idNumber.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: CopyToClipboard(
                        value: client.idNumber,
                        prefix: localization.id,
                      ),
                    ),
                  if (client.vatNumber.isNotEmpty)
                    CopyToClipboard(
                      value: client.vatNumber,
                      prefix: localization.vat,
                    ),
                  SizedBox(height: 4),
                  if (client.phone.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: CopyToClipboard(
                        value: client.phone,
                        child: IconText(icon: Icons.phone, text: client.phone),
                      ),
                    ),
                  if (client.website.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: InkWell(
                        onTap: () =>
                            launchUrl(Uri.parse(untrimUrl(client.website))),
                        child: IconText(
                          icon: MdiIcons.earth,
                          text: trimUrl(client.website),
                        ),
                      ),
                    ),
                  SizedBox(height: 4),
                  if (client.currencyId != state.company.currencyId)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        state.staticState.currencyMap[client.currencyId]
                                ?.name ??
                            '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (client.languageId != state.company.languageId)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        state.staticState.languageMap[client.languageId]
                                ?.name ??
                            '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if ((client.settings.defaultTaskRate ?? 0) != 0)
                    Text(
                        '${localization.taskRate}: ${client.settings.defaultTaskRate}'),
                  if (client.customValue1.isNotEmpty)
                    Text(company.formatCustomFieldValue(
                        CustomFieldType.client1, client.customValue1)),
                  if (client.customValue2.isNotEmpty)
                    Text(company.formatCustomFieldValue(
                        CustomFieldType.client2, client.customValue2)),
                  if (client.customValue3.isNotEmpty)
                    Text(company.formatCustomFieldValue(
                        CustomFieldType.client3, client.customValue3)),
                  if (client.customValue4.isNotEmpty)
                    Text(company.formatCustomFieldValue(
                        CustomFieldType.client4, client.customValue4)),
                ],
              ),
            ),
          ),
          Expanded(
              child: FormCard(
            isLast: true,
            constraints: BoxConstraints(minHeight: minHeight),
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.only(
                top: kMobileDialogPadding,
                right: kMobileDialogPadding / 2,
                bottom: kMobileDialogPadding,
                left: kMobileDialogPadding / 2),
            child: ListView(
              controller: _scrollController2,
              children: [
                Text(
                  localization.address,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                if (billingAddress.isNotEmpty) ...[
                  Text(
                    localization.billingAddress,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CopyToClipboard(
                          value: billingAddress,
                          child: Row(
                            children: [
                              Flexible(child: Text(billingAddress)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          launchUrl(Uri(
                              scheme: 'https',
                              host: 'maps.google.com',
                              queryParameters: <String, dynamic>{
                                'daddr': billingAddress
                              }));
                        },
                        icon: Icon(Icons.map),
                        tooltip: state.prefState.enableTooltips
                            ? localization.viewMap
                            : '',
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                ],
                if (shippingAddress.isNotEmpty) ...[
                  Text(
                    localization.shippingAddress,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CopyToClipboard(
                          value: shippingAddress,
                          child: Row(
                            children: [
                              Flexible(child: Text(shippingAddress)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                          onPressed: () {
                            launchUrl(Uri(
                                scheme: 'https',
                                host: 'maps.google.com',
                                queryParameters: <String, dynamic>{
                                  'daddr': shippingAddress
                                }));
                          },
                          icon: Icon(Icons.map)),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
                if (client.publicNotes.isNotEmpty)
                  CopyToClipboard(value: client.publicNotes),
              ],
            ),
          )),
          Expanded(
              child: FormCard(
            isLast: true,
            constraints: BoxConstraints(minHeight: minHeight),
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: EdgeInsets.only(
                top: kMobileDialogPadding,
                right: kMobileDialogPadding / (!showStanding ? 1 : 2),
                bottom: kMobileDialogPadding,
                left: kMobileDialogPadding / 2),
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController3,
              child: ListView(
                controller: _scrollController3,
                children: [
                  Text(
                    localization.contacts +
                        (hasMultipleContacts
                            ? ' (${client.contacts.length})'
                            : ''),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  ...client.contacts.map((contact) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contact.fullName,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              if (contact.email.isNotEmpty)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: CopyToClipboard(
                                    value: contact.email,
                                    child: IconText(
                                        icon: Icons.email, text: contact.email),
                                  ),
                                ),
                              if (contact.phone.isNotEmpty)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: CopyToClipboard(
                                    value: contact.phone,
                                    child: IconText(
                                        icon: Icons.phone, text: contact.phone),
                                  ),
                                ),
                              if (company.hasCustomField(
                                      CustomFieldType.contact1) &&
                                  contact.customValue1.isNotEmpty)
                                Text(company.formatCustomFieldValue(
                                    CustomFieldType.contact1,
                                    contact.customValue1)),
                              if (company.hasCustomField(
                                      CustomFieldType.contact2) &&
                                  contact.customValue2.isNotEmpty)
                                Text(company.formatCustomFieldValue(
                                    CustomFieldType.contact2,
                                    contact.customValue2)),
                              if (company.hasCustomField(
                                      CustomFieldType.contact3) &&
                                  contact.customValue3.isNotEmpty)
                                Text(company.formatCustomFieldValue(
                                    CustomFieldType.contact3,
                                    contact.customValue3)),
                              if (company.hasCustomField(
                                      CustomFieldType.contact4) &&
                                  contact.customValue4.isNotEmpty)
                                Text(company.formatCustomFieldValue(
                                    CustomFieldType.contact4,
                                    contact.customValue4)),
                              SizedBox(height: 8),
                              if (!hasMultipleContacts) ...[
                                PortalLinks(
                                  viewLink: contact.silentLink,
                                  copyLink: contact.link,
                                  client: client,
                                  style: PortalLinkStyle.buttons,
                                ),
                                SizedBox(height: 16),
                              ] else
                                SizedBox(height: 8),
                            ],
                          ),
                        ),
                        if (hasMultipleContacts)
                          PortalLinks(
                            client: client,
                            viewLink: contact.silentLink,
                            copyLink: contact.link,
                            style: PortalLinkStyle.dropdown,
                          )
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          )),
          if (showStanding)
            Expanded(
              flex: 2,
              child: FormCard(
                isLast: true,
                crossAxisAlignment: CrossAxisAlignment.start,
                constraints:
                    BoxConstraints(minHeight: minHeight, maxHeight: 600),
                padding: const EdgeInsets.only(
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding,
                    bottom: kMobileDialogPadding,
                    left: kMobileDialogPadding / 2),
                child: DefaultTabController(
                  length: company.isModuleEnabled(EntityType.document) ? 5 : 4,
                  child: SizedBox(
                    height: minHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(
                              child: Text(localization.standing),
                            ),
                            if (tokenMap.keys.isNotEmpty)
                              Tab(
                                text:
                                    '${localization.paymentMethods} (${tokenMap.keys.length})',
                              ),
                            if (company.isModuleEnabled(EntityType.document))
                              Tab(
                                text: documents.isEmpty
                                    ? localization.documents
                                    : '${localization.documents} (${documents.length})',
                              ),
                            Tab(
                              text: localization.ledger,
                            ),
                            Tab(
                              text: localization.activity,
                            ),
                            Tab(
                              text: localization.systemLogs,
                            ),
                          ],
                        ),
                        Flexible(
                          child: TabBarView(
                            children: [
                              ListView(
                                children: [
                                  EntityHeader(
                                    entity: client,
                                    label: localization.paidToDate,
                                    value: formatNumber(
                                        client.paidToDate, context,
                                        clientId: client.id),
                                    secondLabel: localization.balanceDue,
                                    secondValue: formatNumber(
                                        client.balance, context,
                                        clientId: client.id),
                                  ),
                                  if (client.privateNotes.isNotEmpty)
                                    IconText(
                                      text: client.privateNotes,
                                      icon: Icons.lock,
                                      copyToClipboard: true,
                                    )
                                ],
                              ),
                              if (tokenMap.keys.isNotEmpty)
                                RefreshIndicator(
                                  onRefresh: () =>
                                      viewModel.onRefreshed(context),
                                  child: ClientViewPaymentMethods(
                                    viewModel: viewModel,
                                    key: ValueKey(viewModel.client.id),
                                    gatewayMap: gatewayMap,
                                    linkMap: linkMap,
                                    tokenMap: tokenMap,
                                  ),
                                ),
                              if (company.isModuleEnabled(EntityType.document))
                                RefreshIndicator(
                                  onRefresh: () =>
                                      viewModel.onRefreshed(context),
                                  child: ClientViewDocuments(
                                    viewModel: viewModel,
                                    key: ValueKey(viewModel.client.id),
                                  ),
                                ),
                              RefreshIndicator(
                                onRefresh: () => viewModel.onRefreshed(context),
                                child: ClientViewLedger(
                                  viewModel: viewModel,
                                  key: ValueKey(viewModel.client.id),
                                ),
                              ),
                              RefreshIndicator(
                                onRefresh: () => viewModel.onRefreshed(context),
                                child: ClientViewActivity(
                                  viewModel: viewModel,
                                  key: ValueKey(viewModel.client.id),
                                ),
                              ),
                              RefreshIndicator(
                                onRefresh: () => viewModel.onRefreshed(context),
                                child: ClientViewSystemLogs(
                                  viewModel: viewModel,
                                  key: ValueKey(viewModel.client.id),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
