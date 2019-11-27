import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_documents.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_overview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityViewVM viewModel;

  @override
  _InvoiceViewState createState() => new _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: _CustomAppBar(
          viewModel: viewModel,
          controller: _controller,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: CustomTabBarView(
                viewModel: viewModel,
                controller: _controller,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({
    @required this.viewModel,
    @required this.controller,
  });

  final EntityViewVM viewModel;
  final TabController controller;

  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return TabBarView(
      controller: widget.controller,
      children: <Widget>[
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: InvoiceOverview(viewModel: viewModel),
        ),
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: InvoiceViewDocuments(
              viewModel: viewModel, invoice: viewModel.invoice),
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    @required this.viewModel,
    @required this.controller,
  });

  final EntityViewVM viewModel;
  final TabController controller;

  @override
  final Size preferredSize = const Size(double.infinity, kToolbarHeight * 2);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = viewModel.invoice;
    final userCompany = viewModel.state.userCompany;
    final client = viewModel.client;
    final documentState = viewModel.state.documentState;
    final documents = memoizedInvoiceDocumentsSelector(
        documentState.map, viewModel.state.expenseState.map, invoice);

    return AppBar(
      automaticallyImplyLeading: isMobile(context),
      title: EntityStateTitle(
        entity: invoice,
        title:
            '${localization.invoice} ${invoice.number ?? '• ${localization.pending}'}',
      ),
      bottom: TabBar(
        controller: controller,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: documents.isEmpty
                ? localization.documents
                : '${localization.documents} (${documents.length})',
          ),
        ],
      ),
      actions: invoice.isNew
          ? []
          : [
              userCompany.canEditEntity(invoice)
                  ? EditIconButton(
                      isVisible: !invoice.isDeleted,
                      onPressed: () => viewModel.onEditPressed(context),
                    )
                  : Container(),
              ActionMenuButton(
                entityActions: invoice.getActions(
                    client: client, userCompany: userCompany),
                isSaving: viewModel.isSaving,
                entity: invoice,
                onSelected: viewModel.onActionSelected,
              )
            ],
    );
  }
}
