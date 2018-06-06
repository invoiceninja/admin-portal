import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/ui/client/client_details_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientDetails extends StatelessWidget {
  final ClientDetailsVM viewModel;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();

  ClientDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.client.id == null
            ? AppLocalization.of(context).newClient
            : viewModel
                .client.displayName), // Text(localizations.clientDetails),
        actions: viewModel.client.id == null ? [] : [
          ActionMenuButton(
            entity: viewModel.client,
            onSelected: viewModel.onActionSelected,
          )],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(children: [
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(0.0),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      key: _nameKey,
                      initialValue: viewModel.client.name,
                      decoration: InputDecoration(
                        //border: InputBorder.none,
                        labelText: AppLocalization.of(context).client,
                      ),
                    ),
                    /*
                    TextFormField(
                      initialValue: viewModel.client.notes,
                      key: _notesKey,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: AppLocalization.of(context).notes,
                      ),
                    ),
                    TextFormField(
                      initialValue: viewModel.client.cost == null ||
                              viewModel.client.cost == 0.0
                          ? null
                          : viewModel.client.cost.toStringAsFixed(2),
                      key: _costKey,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        //border: InputBorder.none,
                        labelText: AppLocalization.of(context).cost,
                      ),
                    ),
                    */
                  ],
                ),
              ),
            ),
          ),
          new Builder(builder: (BuildContext context) {
            return viewModel.client.isDeleted == true
                ? Container()
                : ProgressButton(
                    label: AppLocalization.of(context).save.toUpperCase(),
                    isLoading: viewModel.isLoading,
                    isDirty: viewModel.isDirty,
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      viewModel.onSaveClicked(context,
                          viewModel.client.rebuild((b) => b
                            ..name = _nameKey.currentState.value)
                      );
                    },
                  );
          }),
        ]),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.editClientFab,
        tooltip: localizations.editClient,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EditClient(
                  client: client,
                );
              },
            ),
          );
        },
      ),
      */
    );
  }
}
