import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_tab_bar.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/portal_links.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_activity.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_documents.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_ledger.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_system_logs.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientViewFullwidth extends StatefulWidget {
  const ClientViewFullwidth({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientViewVM viewModel;

  @override
  State<ClientViewFullwidth> createState() => _ClientViewFullwidthState();
}

class _ClientViewFullwidthState extends State<ClientViewFullwidth>
    with TickerProviderStateMixin {
  ScrollController _scrollController1;
  ScrollController _scrollController2;
  ScrollController _scrollController3;

  @override
  void initState() {
    super.initState();

    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final client = state.clientState.get(state.uiState.filterEntityId);
    final documents = client.documents;
    final viewModel = widget.viewModel;
    final billingAddress = formatAddress(state, object: client);
    final shippingAddress =
        formatAddress(state, object: client, isShipping: true);

    final showStanding = !state.prefState.isPreviewVisible &&
        !state.uiState.isEditing &&
        state.prefState.isModuleTable;

    final availableCredits =
        memoizedGetClientAvailableCredits(client.id, state.creditState.map);
    final unappliedPayments =
        memoizedGetClientUnappliedPayments(client.id, state.paymentState.map);

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
                    localization.details,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  if (availableCredits != 0)
                    Text(localization.credit +
                        ': ' +
                        formatNumber(availableCredits, context,
                            clientId: client.id)),
                  if (unappliedPayments != 0)
                    Text(localization.payments +
                        ': ' +
                        formatNumber(unappliedPayments, context,
                            clientId: client.id)),
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
                        onTap: () => launchUrl(Uri.parse(client.website)),
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
                  if ((client.languageId ?? '').isNotEmpty &&
                      client.languageId != state.company.settings.languageId)
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
                  style: Theme.of(context).textTheme.headline6,
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
            child: ListView(
              controller: _scrollController3,
              children: [
                Text(
                  localization.contacts +
                      (client.contacts.length > 1
                          ? ' (${client.contacts.length})'
                          : ''),
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                ...client.contacts.map((contact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.fullName,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      if (contact.email.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CopyToClipboard(
                            value: contact.email,
                            child: IconText(
                                icon: Icons.email, text: contact.email),
                          ),
                        ),
                      if (contact.phone.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CopyToClipboard(
                            value: contact.phone,
                            child: IconText(
                                icon: Icons.phone, text: contact.phone),
                          ),
                        ),
                      SizedBox(height: 8),
                      PortalLinks(
                        viewLink: contact.silentLink,
                        copyLink: contact.link,
                        client: client,
                        useIcons: true,
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ],
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
                  length: 5,
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
                              RefreshIndicator(
                                onRefresh: () => viewModel.onRefreshed(context),
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
