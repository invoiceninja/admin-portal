import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_tab_bar.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_documents.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorViewFullwidth extends StatefulWidget {
  const VendorViewFullwidth({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorViewVM viewModel;

  @override
  State<VendorViewFullwidth> createState() => _VendorViewFullwidthState();
}

class _VendorViewFullwidthState extends State<VendorViewFullwidth>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final vendor = state.vendorState.get(state.uiState.filterEntityId);
    final documents = vendor.documents;
    final viewModel = widget.viewModel;
    final billingAddress = formatAddress(state, object: vendor);

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
                  right: kMobileDialogPadding / 3,
                  bottom: kMobileDialogPadding,
                  left: kMobileDialogPadding),
              children: [
                Text(
                  localization.details,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 4),
                if (vendor.idNumber.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: CopyToClipboard(
                      value: vendor.idNumber,
                      prefix: localization.id,
                    ),
                  ),
                if (vendor.vatNumber.isNotEmpty)
                  CopyToClipboard(
                    value: vendor.vatNumber,
                    prefix: localization.vat,
                  ),
                SizedBox(height: 4),
                if (vendor.phone.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CopyToClipboard(
                      value: vendor.phone,
                      child: IconText(icon: Icons.phone, text: vendor.phone),
                    ),
                  ),
                if (vendor.website.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CopyToClipboard(
                      value: vendor.website,
                      child:
                          IconText(icon: MdiIcons.earth, text: vendor.website),
                    ),
                  ),
                SizedBox(height: 4),
                if (vendor.currencyId != state.company.currencyId)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Text(
                      state.staticState.currencyMap[vendor.currencyId]?.name ??
                          '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
              child: FormCard(
            isLast: true,
            constraints: BoxConstraints(minHeight: minHeight),
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.only(
                top: kMobileDialogPadding,
                right: kMobileDialogPadding / 3,
                bottom: kMobileDialogPadding,
                left: kMobileDialogPadding / 3),
            children: [
              Text(
                localization.address,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 4),
              if (billingAddress.isNotEmpty) ...[
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
                          launch('http://maps.google.com/?daddr=' +
                              Uri.encodeQueryComponent(billingAddress));
                        },
                        icon: Icon(Icons.map))
                  ],
                ),
                SizedBox(height: 8),
              ],
            ],
          )),
          Expanded(
              child: FormCard(
            isLast: true,
            constraints: BoxConstraints(minHeight: minHeight),
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: EdgeInsets.only(
                top: kMobileDialogPadding,
                right: kMobileDialogPadding /
                    (state.prefState.isPreviewVisible ? 1 : 3),
                bottom: kMobileDialogPadding,
                left: kMobileDialogPadding / 3),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Text(
                  localization.contacts,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 4),
                ...vendor.contacts.map((contact) {
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
                      SizedBox(height: 16),
                    ],
                  );
                }).toList()
              ],
            )),
          )),
          if (!state.prefState.isPreviewVisible && !state.uiState.isEditing)
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
                    left: kMobileDialogPadding / 3),
                child: DefaultTabController(
                  length: 2,
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
                          ],
                        ),
                        Flexible(
                          child: TabBarView(
                            children: [
                              EntityHeader(
                                entity: vendor,
                                label: localization.total,
                                value: formatNumber(
                                    memoizedCalculateVendorBalance(
                                        vendor.id,
                                        vendor.currencyId,
                                        state.expenseState.map,
                                        state.expenseState.list),
                                    context,
                                    currencyId: vendor.currencyId ??
                                        state.company.currencyId),
                              ),
                              RefreshIndicator(
                                onRefresh: () => viewModel.onRefreshed(context),
                                child: VendorViewDocuments(
                                  viewModel: viewModel,
                                  key: ValueKey(viewModel.vendor.id),
                                ),
                              ),
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
