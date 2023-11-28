// Dart imports:
import 'dart:convert';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/ui/app/app_webview.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_tab_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/variables.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/designs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class DesignEdit extends StatefulWidget {
  const DesignEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DesignEditVM viewModel;

  @override
  _DesignEditState createState() => _DesignEditState();
}

class _DesignEditState extends State<DesignEdit>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_designEdit');

  final _debouncer = Debouncer();
  final _htmlDebouncer = SimpleDebouncer();

  final _nameController = TextEditingController();
  final _htmlController = TextEditingController();
  final _headerController = TextEditingController();
  final _footerController = TextEditingController();
  final _bodyController = TextEditingController();
  final _productsController = TextEditingController();
  final _tasksController = TextEditingController();
  final _includesController = TextEditingController();

  FocusScopeNode? _focusNode;
  TabController? _tabController;
  Uint8List? _pdfBytes;
  String _html = '';
  bool _isLoading = false;
  bool _isDraftMode = false;

  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _htmlController.addListener(_onHtmlChanged);
    _focusNode = FocusScopeNode();
    _tabController = TabController(
        vsync: this, length: widget.viewModel.state.prefState.isMobile ? 6 : 5);
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
      _headerController,
      _footerController,
      _bodyController,
      _productsController,
      _tasksController,
      _includesController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final design = widget.viewModel.design;
    _nameController.text = design.name;
    _headerController.text = design.getSection(kDesignHeader)!;
    _footerController.text = design.getSection(kDesignFooter)!;
    _bodyController.text = design.getSection(kDesignBody)!;
    _productsController.text = design.getSection(kDesignProducts)!;
    _tasksController.text = design.getSection(kDesignTasks)!;
    _includesController.text = design.getSection(kDesignIncludes)!;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    _loadDesign(design);

    _loadPreview(context, design);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    _tabController!.dispose();

    _htmlController.removeListener(_onHtmlChanged);
    _htmlController.dispose();

    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged({bool debounce = true}) {
    final design = widget.viewModel.design.rebuild((b) => b
      ..name = _nameController.text.trim()
      ..design.replace(BuiltMap<String, String>({
        kDesignHeader: _headerController.text.trim(),
        kDesignBody: _bodyController.text.trim(),
        kDesignFooter: _footerController.text.trim(),
        kDesignProducts: _productsController.text.trim(),
        kDesignTasks: _tasksController.text.trim(),
        kDesignIncludes: _includesController.text.trim()
      })));

    if (design != widget.viewModel.design) {
      if (debounce) {
        _debouncer.run(() {
          widget.viewModel.onChanged(design);
          _loadPreview(context, design);
        });
      } else {
        widget.viewModel.onChanged(design);
        _loadPreview(context, design);
      }
    }
  }

  void _onHtmlChanged() {
    _htmlDebouncer.run(() {
      setState(() {
        _html = _htmlController.text;
      });
    });
  }

  void _loadDesign(DesignEntity design) {
    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final htmlDesign = design.design;
    _headerController.text = htmlDesign[kDesignHeader]!;
    _bodyController.text = htmlDesign[kDesignBody]!;
    _footerController.text = htmlDesign[kDesignFooter]!;
    _productsController.text = htmlDesign[kDesignProducts]!;
    _tasksController.text = htmlDesign[kDesignTasks]!;
    _includesController.text = htmlDesign[kDesignIncludes]!;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    _onChanged(debounce: false);
  }

  void _loadPreview(BuildContext context, DesignEntity design) async {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    loadDesign(
        context: context,
        design: design,
        isDraftMode: _isDraftMode,
        isPurchaseOrder: false,
        onComplete: (response) async {
          setState(() {
            _isLoading = false;

            if (response != null) {
              if (_isDraftMode) {
                _htmlController.text = response.body;
                _html = response.body;
                _pdfBytes = null;
              } else {
                _pdfBytes = response.bodyBytes;
                _html = '';
              }
            }
          });
        });
  }

  void _setDraftMode(bool isDraftMode) {
    setState(() {
      _isDraftMode = isDraftMode;
    });

    _loadPreview(context, widget.viewModel.design);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final design = viewModel.design;

    return EditScaffold(
        entity: design,
        isFullscreen: true,
        title:
            design.isNew ? localization!.newDesign : localization!.editDesign,
        onCancelPressed: (context) => viewModel.onCancelPressed(context),
        appBarBottom: isMobile(context)
            ? TabBar(
                //key: ValueKey(state.settingsUIState.updatedAt),
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(text: localization.settings),
                  Tab(text: localization.preview),
                  Tab(text: localization.body),
                  Tab(text: localization.header),
                  Tab(text: localization.footer),
                  //Tab(text: localization.products),
                  //Tab(text: localization.tasks),
                  Tab(text: localization.includes),
                ],
              )
            : null,
        onSavePressed: _isLoading
            ? null
            : (context) {
                final bool isValid = _formKey.currentState!.validate();

                if (!isValid) {
                  return;
                }

                viewModel.onSavePressed(context);
              },
        body: isMobile(context)
            ? AppTabForm(
                tabController: _tabController,
                formKey: _formKey,
                focusNode: _focusNode,
                children: <Widget>[
                    DesignSettings(
                      viewModel: viewModel,
                      isLoading: _isLoading,
                      nameController: _nameController,
                      htmlController: _htmlController,
                      onLoadDesign: _loadDesign,
                      draftMode: _isDraftMode,
                      onDraftModeChanged: (value) => _setDraftMode(value),
                    ),
                    _isDraftMode
                        ? HtmlDesignPreview(
                            html: _html,
                            isLoading: _isLoading,
                          )
                        : PdfDesignPreview(
                            pdfBytes: _pdfBytes,
                            isLoading: _isLoading,
                          ),
                    DesignSection(textController: _bodyController),
                    DesignSection(textController: _headerController),
                    DesignSection(textController: _footerController),
                    //DesignSection(textController: _productsController),
                    //DesignSection(textController: _tasksController),
                    DesignSection(textController: _includesController),
                  ])
            : AppForm(
                focusNode: _focusNode,
                formKey: _formKey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          AppTabBar(
                            controller: _tabController,
                            isScrollable: true,
                            tabs: <Widget>[
                              Tab(text: localization.settings),
                              Tab(text: localization.body),
                              Tab(text: localization.header),
                              Tab(text: localization.footer),
                              //Tab(text: localization.products),
                              //Tab(text: localization.tasks),
                              Tab(text: localization.includes),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                DesignSettings(
                                  viewModel: viewModel,
                                  isLoading: _isLoading,
                                  nameController: _nameController,
                                  htmlController: _htmlController,
                                  onLoadDesign: _loadDesign,
                                  draftMode: _isDraftMode,
                                  onDraftModeChanged: (value) =>
                                      _setDraftMode(value),
                                ),
                                DesignSection(textController: _bodyController),
                                DesignSection(
                                    textController: _headerController),
                                DesignSection(
                                    textController: _footerController),
                                //DesignSection(textController: _productsController),
                                //DesignSection(textController: _productsController),
                                DesignSection(
                                    textController: _includesController),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: _isDraftMode
                          ? HtmlDesignPreview(
                              html: _html,
                              isLoading: _isLoading,
                            )
                          : PdfDesignPreview(
                              pdfBytes: _pdfBytes,
                              isLoading: _isLoading,
                            ),
                    ),
                  ],
                ),
              ));
  }
}

class DesignSection extends StatelessWidget {
  const DesignSection({required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Actions(
            actions: {InsertTabIntent: InsertTabAction()},
            child: Shortcuts(
              shortcuts: {
                LogicalKeySet(LogicalKeyboardKey.tab):
                    InsertTabIntent(4, textController),
              },
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 16,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
                autocorrect: false,
                autofocus: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DesignSettings extends StatefulWidget {
  const DesignSettings({
    required this.viewModel,
    required this.nameController,
    required this.htmlController,
    required this.onLoadDesign,
    required this.draftMode,
    required this.onDraftModeChanged,
    required this.isLoading,
  });

  final DesignEditVM viewModel;
  final Function(DesignEntity) onLoadDesign;
  final TextEditingController nameController;
  final TextEditingController htmlController;
  final bool draftMode;
  final bool isLoading;
  final Function(bool) onDraftModeChanged;

  @override
  _DesignSettingsState createState() => _DesignSettingsState();
}

class _DesignSettingsState extends State<DesignSettings> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final state = widget.viewModel.state;
    final design = widget.viewModel.design;
    final entityTypes = design.entities.split(',');

    return ScrollableListView(
      primary: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              label: localization.name,
              controller: widget.nameController,
              keyboardType: TextInputType.text,
              validator: (value) =>
                  value.isEmpty ? localization.pleaseEnterAName : null,
            ),
            DesignPicker(
              showBlank: true,
              label: localization.loadDesign,
              onSelected: (value) {
                if (value != null) {
                  widget.onLoadDesign(value);
                }
              },
            ),
            SizedBox(height: 20),
            // TODO remove this once browser supported on all platforms
            if (!kReleaseMode || kIsWeb || isMobileOS())
              SwitchListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: Text(localization.draftMode),
                subtitle: Text(localization.draftModeHelp),
                value: widget.draftMode,
                onChanged: widget.isLoading ? null : widget.onDraftModeChanged,
              ),
            if (supportsDesignTemplates())
              SwitchListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: Text(localization.template),
                subtitle: Text(localization.templateHelp),
                value: design.isTemplate,
                onChanged: (value) {
                  widget.viewModel.onChanged(
                    design.rebuild((b) => b..isTemplate = value),
                  );
                },
              ),
            if (design.isTemplate) ...[
              SizedBox(height: 10),
              ...[
                EntityType.client,
                EntityType.invoice,
                EntityType.payment,
                EntityType.quote,
                EntityType.credit,
                EntityType.project,
                EntityType.task,
                EntityType.purchaseOrder,
              ]
                  .where(
                      (entityType) => state.company.isModuleEnabled(entityType))
                  .map((entityType) => CheckboxListTile(
                        value: entityTypes.contains(entityType.apiValue),
                        onChanged: (value) {
                          final entities = entityTypes;
                          if (value == true) {
                            entities.add(entityType.apiValue);
                          } else {
                            entities.remove(entityType.apiValue);
                          }
                          widget.viewModel.onChanged(design.rebuild((b) => b
                            ..entities = entities
                                .where((entity) => entity.isNotEmpty)
                                .join(',')));
                        },
                        title: Text(localization.lookup(entityType.plural)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ))
                  .toList(),
            ],
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      localization.viewDocs.toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () => launchUrl(Uri.parse(kDocsCustomDesignUrl)),
                ),
              ),
              SizedBox(width: kTableColumnGap),
              Expanded(
                child: OutlinedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      localization.import.toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () async {
                    final designStr = await showDialog<String>(
                        context: context,
                        builder: (context) => _DesignImportDialog());
                    final viewModel = widget.viewModel;
                    final design = viewModel.design;

                    widget.onLoadDesign(design.rebuild((b) => b
                      ..design.replace(
                          BuiltMap<String, String>(jsonDecode(designStr!)))));
                    showToast(localization.importedDesign);
                  },
                ),
              ),
              SizedBox(width: kTableColumnGap),
              Expanded(
                child: OutlinedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      localization.export.toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () {
                    final design = widget.viewModel.design;
                    final designMap = design.design.toMap();

                    // TODO remove this code once it's supported
                    designMap.remove(kDesignProducts);
                    designMap.remove(kDesignTasks);

                    final encoder = new JsonEncoder.withIndent('  ');
                    final prettyprint = encoder.convert(designMap);

                    Clipboard.setData(ClipboardData(text: prettyprint));
                    showToast(localization.copiedToClipboard
                        .replaceFirst(':value ', ''));
                  },
                ),
              ),
            ],
          ),
        ),
        if (widget.draftMode)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 30, right: 30),
                child: Text(
                  localization.htmlPreviewWarning,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              FormCard(
                child: Actions(
                  actions: {InsertTabIntent: InsertTabAction()},
                  child: Shortcuts(
                    shortcuts: {
                      LogicalKeySet(LogicalKeyboardKey.tab):
                          InsertTabIntent(4, widget.htmlController)
                    },
                    child: TextField(
                      controller: widget.htmlController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 16,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          VariablesHelp(),
      ],
    );
  }
}

class PdfDesignPreview extends StatefulWidget {
  const PdfDesignPreview({
    required this.pdfBytes,
    required this.isLoading,
  });

  final Uint8List? pdfBytes;

  final bool isLoading;

  @override
  _PdfDesignPreviewState createState() => _PdfDesignPreviewState();
}

class _PdfDesignPreviewState extends State<PdfDesignPreview> {
  String get _pdfString {
    if (widget.pdfBytes == null) {
      return '';
    }

    return 'data:application/pdf;base64,' + base64Encode(widget.pdfBytes!);
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pdfBytes == widget.pdfBytes) {
      return;
    }

    if (kIsWeb) {
      WebUtils.registerWebView(_pdfString);
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (widget.pdfBytes == null)
            SizedBox()
          else if (kIsWeb && state.prefState.enableNativeBrowser)
            HtmlElementView(viewType: _pdfString)
          else if (widget.pdfBytes != null)
            PdfPreview(
              build: (format) => widget.pdfBytes!,
              canChangeOrientation: false,
              canChangePageFormat: false,
              allowPrinting: false,
              allowSharing: false,
              canDebug: false,
              maxPageWidth: 800,
            )
          else
            SizedBox(),
          if (widget.isLoading)
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                LinearProgressIndicator(),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class HtmlDesignPreview extends StatelessWidget {
  const HtmlDesignPreview({
    required this.html,
    required this.isLoading,
  });

  final String html;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AppWebView(html: html),
          if (isLoading)
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                LinearProgressIndicator(),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// https://stackoverflow.com/a/66575876/497368
class InsertTabIntent extends Intent {
  const InsertTabIntent(this.numSpaces, this.textController);
  final int numSpaces;
  final TextEditingController textController;
}

class InsertTabAction extends Action {
  @override
  Object invoke(covariant Intent intent) {
    if (intent is InsertTabIntent) {
      final oldValue = intent.textController.value;
      final newComposing = TextRange.collapsed(oldValue.composing.start);
      final newSelection = TextSelection.collapsed(
          offset: oldValue.selection.start + intent.numSpaces);

      final newText = StringBuffer(oldValue.selection.isValid
          ? oldValue.selection.textBefore(oldValue.text)
          : oldValue.text);
      for (var i = 0; i < intent.numSpaces; i++) {
        newText.write(' ');
      }
      newText.write(oldValue.selection.isValid
          ? oldValue.selection.textAfter(oldValue.text)
          : '');
      intent.textController.value = intent.textController.value.copyWith(
        composing: newComposing,
        text: newText.toString(),
        selection: newSelection,
      );
    }
    return '';
  }
}

class _DesignImportDialog extends StatefulWidget {
  const _DesignImportDialog({Key? key}) : super(key: key);

  @override
  State<_DesignImportDialog> createState() => __DesignImportDialogState();
}

class __DesignImportDialogState extends State<_DesignImportDialog> {
  var _design = '';

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return AlertDialog(
      title: Text(localization.importDesign),
      content: DecoratedFormField(
        autofocus: true,
        autocorrect: false,
        label: localization.design,
        keyboardType: TextInputType.multiline,
        maxLines: 8,
        onChanged: (value) => _design = value,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localization.cancel.toUpperCase()),
        ),
        TextButton(
          onPressed: () {
            final value = _design.trim();
            try {
              final Map<String, dynamic>? map = jsonDecode(value);
              for (var field in [
                kDesignBody,
                kDesignFooter,
                kDesignHeader,
                kDesignIncludes
              ]) {
                if (!map!.containsKey(field)) {
                  throw localization.invalidDesign
                      .replaceFirst(':value', field);
                }
              }
              Navigator.of(context).pop(value);
            } catch (error) {
              showErrorDialog(message: '$error');
            }
          },
          child: Text(localization.done.toUpperCase()),
        ),
      ],
    );
  }
}
