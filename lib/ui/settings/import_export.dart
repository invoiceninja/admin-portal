import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/import_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/import_export_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
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
  PreImportResponse _response;

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

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

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
            if (_response == null)
              _FileImport(
                onUploaded: (response) => setState(() => _response = response),
              )
            else
              _FileMapper(
                key: ValueKey(_response.hash),
                formKey: _formKey,
                response: _response,
                onCancelPressed: () => setState(() => _response = null),
              ),
          ],
        ),
      ),
    );
  }
}

class _FileImport extends StatefulWidget {
  const _FileImport({@required this.onUploaded});

  final Function(PreImportResponse) onUploaded;

  @override
  _FileImportState createState() => _FileImportState();
}

class _FileImportState extends State<_FileImport> {
  String _filePath;
  String _fileName;
  bool _isLoading = false;

  void uploadFile() {
    if (kIsWeb) {
      final webClient = WebClient();
      final state = StoreProvider.of<AppState>(context).state;
      final credentials = state.credentials;
      final url = '${credentials.url}/preimport';

      setState(() => _isLoading = true);

      webClient
          .post(
        url,
        credentials.token,
        filePath: _filePath,
        fileIndex: 'file',
      )
          .then((dynamic result) {
        setState(() => _isLoading = false);
        final response =
            serializers.deserializeWith(PreImportResponse.serializer, result);

        widget.onUploaded(response);
      }).catchError((dynamic error) {
        setState(() => _isLoading = false);
        showErrorDialog(context: context, message: '$error');
      });
    } else {
      //const dataStr = '{"hash":"GdfMUa4ULdW6fTP4IXIB4LBQlxHZVH64","headers":[["Client","Email","User","Invoice Number","Amount","Paid","PO Number","Status","Invoice Date","Due Date","Discount","Partial\/Deposit","Partial Due Date","Public Notes","Private Notes","surcharge Label","tax tax","crv","ody","Item Product","Item Notes","prod1","prod2","Item Cost","Item Quantity","Item Tax Name","Item Tax Rate","Item Tax Name","Item Tax Rate"],["Test","g@gmail.com","David Bomba","0001","\$10.00","\$10.00","","Archived","2016-02-01","","","\$0.00","","","","0","0","","","10","Green Men","","","10","1","","0","","0"]]}';
      const dataStr =
          '{"hash":"GdfMUa4ULdW6fTP4IXIB4LBQlxHZVH64","available":["client","invoice_number","user"],"headers":[["Client","Email","User","Invoice Number","Amount","Paid","PO Number","Status","Invoice Date","Due Date","Discount","Partial\/Deposit","Partial Due Date"],["Test","g@gmail.com","David Bomba","0001","\$10.00","\$10.00","","Archived","2016-02-01","","","\$0.00","","","","0","0","","","10","Green Men","","","10","1","","0","","0"]]}';

      final response = serializers.deserializeWith(
          PreImportResponse.serializer, json.decode(dataStr));

      print('## respnse: $response');
      widget.onUploaded(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return FormCard(
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
                        child: Text(localization.lookup('$entityType'))))
                    .toList()),
          ),
        ),
        DecoratedFormField(
          key: ValueKey(_fileName),
          enabled: false,
          label: localization.csvFile,
          initialValue: _fileName ?? localization.noFileSelected,
        ),
        SizedBox(height: 20),
        if (_isLoading)
          LinearProgressIndicator()
        else
          Row(
            children: [
              Expanded(
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(localization.selectFile),
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['csv'],
                    );
                    if (result != null) {
                      setState(() {
                        final file = result.files.single;
                        _filePath = kIsWeb
                            ? 'data:application/octet-stream;charset=utf-16le;base64,' +
                                base64Encode(file.bytes)
                            : file.path;
                        _fileName = file.name;
                      });
                    }
                  },
                ),
              ),
              SizedBox(width: kTableColumnGap),
              Expanded(
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(localization.uploadFile),
                  //onPressed: _fileName == null ? null : () => uploadFile(),
                  onPressed: () => uploadFile(),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _FileMapper extends StatefulWidget {
  const _FileMapper({
    Key key,
    @required this.response,
    @required this.onCancelPressed,
    @required this.formKey,
  }) : super(key: key);

  final PreImportResponse response;
  final Function onCancelPressed;
  final GlobalKey<FormState> formKey;

  @override
  __FileMapperState createState() => __FileMapperState();
}

class __FileMapperState extends State<_FileMapper> {
  bool _useFirstRowAsHeaders = true;
  final _mapping = <int, String>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final localization = AppLocalization.of(context);
    final response = widget.response;
    final fields = response.fields1;

    for (var i = 0; i < fields.length; i++) {
      final field = fields[i];
      for (var possible in response.available) {
        final spaceCase = possible.replaceAll('_', ' ');
        final translated = localization.lookup(possible);

        if ([possible, spaceCase, translated].contains(field.toLowerCase())) {
          _mapping[i] = possible;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final response = widget.response;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FormCard(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              activeColor: Theme.of(context).accentColor,
              title: Text(AppLocalization.of(context).firstRowAsColumnNames),
              value: _useFirstRowAsHeaders,
              onChanged: (value) =>
                  setState(() => _useFirstRowAsHeaders = value),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Text(_useFirstRowAsHeaders
                      ? localization.column
                      : localization.sample),
                ),
                Expanded(
                  child: Text(localization.sample),
                ),
                Expanded(
                  child: Text(localization.mapTo),
                ),
              ],
            ),
            SizedBox(height: 12),
            for (var i = 0; i < response.fields1.length; i++)
              _FieldMapper(
                field1: response.fields1[i],
                field2:
                    response.fields2.length > i ? response.fields2[i] : null,
                available: response.available,
                mappedTo: _mapping[i] ?? '',
                mapping: _mapping,
                onMappedToChanged: (String value) {
                  setState(() {
                    _mapping[i] = value;
                    widget.formKey.currentState.validate();
                  });
                },
              ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(localization.cancel),
                    onPressed: () => widget.onCancelPressed(),
                  ),
                ),
                SizedBox(width: kTableColumnGap),
                Expanded(
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(localization.import),
                    onPressed: () {
                      final bool isValid =
                          widget.formKey.currentState.validate();

                      print('## isValid: $isValid');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldMapper extends StatelessWidget {
  const _FieldMapper({
    @required this.field1,
    @required this.field2,
    @required this.mappedTo,
    @required this.available,
    @required this.onMappedToChanged,
    @required this.mapping,
  });

  final String field1;
  final String field2;
  final BuiltList<String> available;
  final String mappedTo;
  final Function onMappedToChanged;
  final Map<int, String> mapping;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    final sorted = available.toList();
    sorted.sort((a, b) => localization.lookup(a).compareTo(localization.lookup(b)));

    return Row(
      children: [
        Expanded(child: Text(field1)),
        Expanded(child: Text(field2 ?? '')),
        Expanded(
            child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: available.contains(mappedTo) ? mappedTo : null,
          validator: (value) => (value ?? '').isNotEmpty &&
                  mapping.values.where((element) => element == value).length > 1
              ? 'ERROR'
              : null,
          onChanged: onMappedToChanged,
          items: [
            DropdownMenuItem<String>(
              child: SizedBox(),
              value: null,
            ),
            ...sorted
                .map(
                  (field) => DropdownMenuItem<String>(
                    child: Text(localization.lookup(field)),
                    value: field,
                  ),
                )
                .toList(),
          ],
        )),
      ],
    );
  }
}
