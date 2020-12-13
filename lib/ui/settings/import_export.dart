import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/import_export_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ImportExport extends StatefulWidget {
  const ImportExport({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ImportExportVM viewModel;

  @override
  _ImportExportState createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_importExport');
  FocusScopeNode _focusNode;
  bool autoValidate = false;
  String _filePath;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged() {}

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    //final viewModel = widget.viewModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: isMobile(context),
        title: Text(localization.importExport),
        actions: <Widget>[],
      ),
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        child: ListView(
          children: [
            FormCard(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: localization.importType,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<EntityType>(
                        isDense: true,
                        value: EntityType.client,
                        onChanged: (dynamic value) {
                          //
                        },
                        items: [EntityType.client]
                            .map((entityType) => DropdownMenuItem<EntityType>(
                                value: entityType,
                                child:
                                    Text(localization.lookup('$entityType'))))
                            .toList()),
                  ),
                ),
                DecoratedFormField(
                  enabled: false,
                  label: localization.csvFile,
                  initialValue: localization.noFileSelected,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(localization.selectFile),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: kTableColumnGap),
                    Expanded(
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(localization.uploadFile),
                        onPressed: _filePath == null ? null : () {
                          //
                        },
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}