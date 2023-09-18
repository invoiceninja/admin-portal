// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_billing_address.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_desktop.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_details.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_footer.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_settings.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_shipping_address.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientEdit extends StatefulWidget {
  const ClientEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  _ClientEditState createState() => _ClientEditState();
}

class _ClientEditState extends State<ClientEdit>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_clientEdit');

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final client = viewModel.client;
    final state = viewModel.state;
    final prefState = state.prefState;
    final isFullscreen = prefState.isEditorFullScreen(EntityType.client);

    return EditScaffold(
      isFullscreen: isFullscreen,
      entity: client,
      title: client.isNew ? localization.newClient : localization.editClient,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState!.validate();
        setState(() {
          //autoValidate = !isValid;
        });

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      appBarBottom: TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.details,
          ),
          Tab(
            text: localization.contacts,
          ),
          Tab(
            text: localization.notes,
          ),
          Tab(
            text: localization.settings,
          ),
          Tab(
            text: localization.billingAddress,
          ),
          Tab(
            text: localization.shippingAddress,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: isFullscreen
            ? ClientEditDesktop(
                viewModel: viewModel,
                key: ValueKey('__client_${client.id}_${client.updatedAt}__'),
              )
            : TabBarView(
                key: ValueKey('__client_${client.id}_${client.updatedAt}__'),
                controller: _controller,
                children: <Widget>[
                  ScrollableListView(
                    children: [
                      ClientEditDetails(viewModel: viewModel),
                    ],
                  ),
                  ClientEditContactsScreen(
                    viewModel: viewModel,
                  ),
                  ScrollableListView(
                    children: [
                      ClientEditNotes(viewModel: viewModel),
                    ],
                  ),
                  ScrollableListView(
                    children: [
                      ClientEditSettings(viewModel: viewModel),
                    ],
                  ),
                  ScrollableListView(
                    children: [
                      ClientEditBillingAddress(viewModel: viewModel),
                    ],
                  ),
                  ScrollableListView(
                    children: [
                      ClientEditShippingAddress(viewModel: viewModel),
                    ],
                  ),
                ],
              ),
      ),
      bottomNavigationBar: ClientEditFooter(client: client),
    );
  }
}
