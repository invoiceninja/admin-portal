import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/import_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/import_export_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
  var _importType = ImportType.csv;
  bool _isExporting = false;

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
        child: ScrollableListView(
          children: [
            if (_response == null)
              _FileImport(
                importType: _importType,
                onUploaded: (response) => {
                  if (_importType == ImportType.csv)
                    {
                      setState(() => _response = response),
                    }
                  else
                    {
                      showToast(localization.startedImport),
                    }
                },
                onImportTypeChanged: (importType) =>
                    setState(() => _importType = importType),
              )
            else
              _FileMapper(
                key: ValueKey(_response.hash),
                importType: _importType,
                formKey: _formKey,
                response: _response,
                onCancelPressed: () => setState(() => _response = null),
              ),
            FormCard(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_isExporting)
                  LinearProgressIndicator()
                else
                  AppButton(
                    iconData: MdiIcons.export,
                    label: localization.export.toUpperCase(),
                    onPressed: () {
                      final webClient = WebClient();
                      final state = StoreProvider.of<AppState>(context).state;
                      final credentials = state.credentials;
                      final url = '${credentials.url}/export';

                      setState(() => _isExporting = true);

                      webClient
                          .post(url, credentials.token)
                          .then((dynamic result) {
                        setState(() => _isExporting = false);
                        showMessageDialog(
                            context: context,
                            message: localization.exportedData);
                      }).catchError((dynamic error) {
                        setState(() => _isExporting = false);
                        showErrorDialog(context: context, message: '$error');
                      });
                    },
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FileImport extends StatefulWidget {
  const _FileImport({
    @required this.importType,
    @required this.onImportTypeChanged,
    @required this.onUploaded,
  });

  final ImportType importType;
  final Function(ImportType) onImportTypeChanged;
  final Function(PreImportResponse) onUploaded;

  @override
  _FileImportState createState() => _FileImportState();
}

class _FileImportState extends State<_FileImport> {
  final Map<String, MultipartFile> _multipartFiles = <String, MultipartFile>{};
  bool _isLoading = false;

  void uploadFile() {
    final localization = AppLocalization.of(context);

    if (widget.importType != ImportType.csv) {
      for (MapEntry<String, String> uploadPart
          in widget.importType.uploadParts.entries) {
        if (!_multipartFiles.containsKey(uploadPart.key)) {
          showErrorDialog(
              context: context, message: localization.requiredFilesMissing);
          return;
        }
      }
    }

    final webClient = WebClient();
    final state = StoreProvider.of<AppState>(context).state;
    final credentials = state.credentials;
    final url = widget.importType == ImportType.csv
        ? '${credentials.url}/preimport'
        : '${credentials.url}/import';

    setState(() => _isLoading = true);

    webClient.post(
      url,
      credentials.token,
      multipartFiles: _multipartFiles.values.toList(),
      data: {
        'import_type': widget.importType.toString(),
      },
    ).then((dynamic result) {
      setState(() => {_isLoading = false, _multipartFiles.clear()});

      if (widget.importType != ImportType.csv) {
        showToast(localization.startedImport);
      } else {
        final response =
            serializers.deserializeWith(PreImportResponse.serializer, result);
        widget.onUploaded(response);
      }
    }).catchError((dynamic error) {
      setState(() => _isLoading = false);
      showErrorDialog(context: context, message: '$error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    final List<Widget> children = [
      InputDecorator(
        decoration: InputDecoration(
          labelText: localization.importType,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<ImportType>(
              isDense: true,
              value: widget.importType,
              onChanged: (dynamic value) => widget.onImportTypeChanged(value),
              items: [
                ImportType.csv,
                ImportType.freshbooks,
                ImportType.invoice2go,
                ImportType.invoicely,
                ImportType.waveaccounting,
                ImportType.zoho,
              ]
                  .map((importType) => DropdownMenuItem<ImportType>(
                      value: importType,
                      child: Text(localization.lookup('$importType'))))
                  .toList()),
        ),
      )
    ];

    for (MapEntry<String, String> uploadPart
        in widget.importType.uploadParts.entries) {
      final multipartFile = _multipartFiles.containsKey(uploadPart.key)
          ? _multipartFiles[uploadPart.key]
          : null;

      final field = DecoratedFormField(
          enabled: false,
          key: ValueKey(uploadPart.key +
              (multipartFile != null ? multipartFile.filename : '')),
          label: localization.lookup(uploadPart.value),
          initialValue: !_multipartFiles.containsKey(uploadPart.key)
              ? localization.noFileSelected
              : '${_multipartFiles[uploadPart.key].filename} • ${formatSize(_multipartFiles[uploadPart.key].length)}');

      children.add(Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(child: field),
        SizedBox(width: kTableColumnGap),
        OutlineButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Text(localization.selectFile),
          onPressed: () async {
            final multipartFile = await pickFile(
              fileIndex: 'files[' + uploadPart.key + ']',
              fileType: FileType.custom,
              allowedExtensions: ['csv'],
            );

            if (multipartFile != null) {
              setState(() {
                _multipartFiles[uploadPart.key] = multipartFile;
              });
            }
          },
        ),
      ]));
    }

    children.add(SizedBox(height: 20));

    if (_isLoading)
      children.add(LinearProgressIndicator());
    else
      children.add(AppButton(
        label: localization.import.toUpperCase(),
        iconData: MdiIcons.import,
        onPressed: _multipartFiles == null ? null : () => uploadFile(),
      ));

    return FormCard(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }
}

class _FileMapper extends StatefulWidget {
  const _FileMapper({
    Key key,
    @required this.importType,
    @required this.response,
    @required this.onCancelPressed,
    @required this.formKey,
  }) : super(key: key);

  final ImportType importType;
  final PreImportResponse response;
  final Function onCancelPressed;
  final GlobalKey<FormState> formKey;

  @override
  __FileMapperState createState() => __FileMapperState();
}

class __FileMapperState extends State<_FileMapper> {
  bool _useFirstRowAsHeaders = true;
  final _mapping = <String, Map<int, String>>{};
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final localization = AppLocalization.of(context);
    final response = widget.response;

    for (MapEntry<String, PreImportResponseEntityDetails> entry
        in response.mappings.entries) {
      final fields = entry.value.fields1;
      if (!_mapping.containsKey(entry.key)) {
        _mapping[entry.key] = <int, String>{};
      }

      for (var i = 0; i < fields.length; i++) {
        final field = fields[i];
        for (var availableField in entry.value.available) {
          final possible = availableField.split('.').last;
          final spaceCase = possible.replaceAll('_', ' ');
          final translated = localization.lookup(possible);

          if ([possible, spaceCase, translated].contains(field.toLowerCase())) {
            _mapping[entry.key][i] = availableField;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final response = widget.response;

    final List<Widget> children = [
      SwitchListTile(
        activeColor: Theme.of(context).accentColor,
        title: Text(AppLocalization.of(context).firstRowAsColumnNames),
        value: _useFirstRowAsHeaders,
        onChanged: (value) => setState(() => _useFirstRowAsHeaders = value),
      ),
    ];

    for (MapEntry<String, PreImportResponseEntityDetails> entry
        in response.mappings.entries) {
      children.addAll([
        SizedBox(height: 25),
        Text(
          localization.lookup(entry.key),
          style: Theme.of(context).textTheme.subtitle1,
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
        SizedBox(height: 12),
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
        for (var i = 0; i < entry.value.fields1.length; i++)
          _FieldMapper(
            field1: entry.value.fields1[i],
            field2:
                entry.value.fields2.length > i ? entry.value.fields2[i] : null,
            available: entry.value.available,
            mappedTo: _mapping[entry.key][i] ?? '',
            mapping: _mapping[entry.key],
            onMappedToChanged: (String value) {
              setState(() {
                if (!_mapping.containsKey(entry.key)) {
                  _mapping[entry.key] = <int, String>{};
                }

                _mapping[entry.key][i] = value;
                widget.formKey.currentState.validate();
              });
            },
          ),
      ]);
    }

    children.addAll([
      SizedBox(height: 25),
      if (_isLoading)
        LinearProgressIndicator()
      else
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
                  final bool isValid = widget.formKey.currentState.validate();

                  if (!isValid) {
                    return;
                  }

                  final webClient = WebClient();
                  final state = StoreProvider.of<AppState>(context).state;
                  final credentials = state.credentials;
                  final url = '${credentials.url}/import';
                  final convertedMapping = <String, ImportRequestMapping>{};

                  for (MapEntry<String, Map<int, String>> e
                      in _mapping.entries) {
                    convertedMapping[e.key] =
                        new ImportRequestMapping(BuiltMap(e.value));
                  }

                  setState(() => _isLoading = true);

                  final importRequest = ImportRequest(
                    hash: widget.response.hash,
                    skipHeader: _useFirstRowAsHeaders,
                    columnMap: BuiltMap(convertedMapping),
                    importType: widget.importType.name,
                  );

                  final data = serializers.serializeWith(
                      ImportRequest.serializer, importRequest);

                  webClient
                      .post(
                    url,
                    credentials.token,
                    data: json.encode(data),
                  )
                      .then((dynamic result) {
                    setState(() => _isLoading = false);
                    widget.onCancelPressed();
                    showToast(localization.startedImport);
                  }).catchError((dynamic error) {
                    setState(() => _isLoading = false);
                    showErrorDialog(context: context, message: '$error');
                  });
                },
              ),
            ),
          ],
        )
    ]);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FormCard(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
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
    sorted.sort((fieldA, fieldB) {
      final partsA = fieldA.split('.');
      final partsB = fieldB.split('.');
      return localization
          .lookup(partsA[1])
          .compareTo(localization.lookup(partsB[1]));
    });

    return Row(
      children: [
        Expanded(child: Text(field1)),
        Expanded(child: Text(field2 ?? '')),
        Expanded(
            child: DropdownButtonFormField<String>(
          isExpanded: true,
          selectedItemBuilder: (BuildContext context) {
            return [
              Text(''),
              ...sorted
                  .map(
                    (field) => Text(
                      localization.lookup(
                        field.split('.').last.replaceAll('_id', ''),
                      ),
                    ),
                  )
                  .toList(),
            ];
          },
          value: available.contains(mappedTo) ? mappedTo : null,
          validator: (value) => (value ?? '').isNotEmpty &&
                  mapping.values.where((element) => element == value).length > 1
              ? localization.duplicateColumnMapping
              : null,
          onChanged: onMappedToChanged,
          items: [
            DropdownMenuItem<String>(
              child: SizedBox(),
              value: '',
            ),
            ...sorted.map(
              (field) {
                final fieldLabel = localization
                    .lookup(field.split('.').last.replaceAll('_id', ''));
                final fieldType = localization.lookup(field.split('.').first);
                return DropdownMenuItem<String>(
                  child: Text(
                    '$fieldLabel - $fieldType',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: field,
                );
              },
            ).toList(),
          ],
        )),
      ],
    );
  }
}
