import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'package:invoiceninja_flutter/utils/designs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';
import 'package:url_launcher/url_launcher.dart';

class DesignEdit extends StatefulWidget {
  const DesignEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DesignEditVM viewModel;

  @override
  _DesignEditState createState() => _DesignEditState();
}

class _DesignEditState extends State<DesignEdit>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_designEdit');

  final _debouncer = Debouncer(milliseconds: kMillisecondsToDebounceSave);

  final _nameController = TextEditingController();
  final _headerController = TextEditingController();
  final _footerController = TextEditingController();
  final _bodyController = TextEditingController();
  final _productsController = TextEditingController();
  final _tasksController = TextEditingController();
  final _includesController = TextEditingController();

  FocusScopeNode _focusNode;
  TabController _tabController;
  Uint8List _pdfBytes;
  String _html = '';
  bool _isLoading = false;
  bool _isDraftMode = false;

  List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _tabController = TabController(
        vsync: this, length: widget.viewModel.state.prefState.isMobile ? 7 : 6);
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
    _headerController.text = design.getSection(kDesignHeader);
    _footerController.text = design.getSection(kDesignFooter);
    _bodyController.text = design.getSection(kDesignBody);
    _productsController.text = design.getSection(kDesignProducts);
    _tasksController.text = design.getSection(kDesignTasks);
    _includesController.text = design.getSection(kDesignIncludes);

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    _loadDesign(design);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _tabController.dispose();
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final design = widget.viewModel.design
        .rebuild((b) => b..name = _nameController.text.trim());

    if (design != widget.viewModel.design) {
      widget.viewModel.onChanged(design);
    }

    _debouncer.run(() {
      final design = widget.viewModel.design.rebuild((b) => b
        ..design.replace(BuiltMap<String, String>({
          kDesignHeader: _headerController.text.trim(),
          kDesignBody: _bodyController.text.trim(),
          kDesignFooter: _footerController.text.trim(),
          kDesignProducts: _productsController.text.trim(),
          kDesignTasks: _tasksController.text.trim() ?? '',
          kDesignIncludes: _includesController.text.trim()
        })));

      if (design != widget.viewModel.design) {
        widget.viewModel.onChanged(design);
        _loadPreview(context, design);
      }
    });
  }

  void _loadDesign(DesignEntity design) {
    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final htmlDesign = design.design;
    _headerController.text = htmlDesign[kDesignHeader];
    _bodyController.text = htmlDesign[kDesignBody];
    _footerController.text = htmlDesign[kDesignFooter];
    _productsController.text = htmlDesign[kDesignProducts];
    _tasksController.text = htmlDesign[kDesignTasks];
    _includesController.text = htmlDesign[kDesignIncludes];

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    _onChanged();
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
        onComplete: (response) async {
          setState(() {
            _isLoading = false;

            if (response != null) {
              if (_isDraftMode) {
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
        isFullscreen: true,
        isAdvancedSettings: true,
        title: design.isNew ? localization.newDesign : localization.editDesign,
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
                  Tab(text: localization.products),
                  //Tab(text: localization.tasks),
                  Tab(text: localization.includes),
                ],
              )
            : null,
        onSavePressed: _isLoading
            ? null
            : (context) {
                final bool isValid = _formKey.currentState.validate();

                /*
        setState(() {
          _autoValidate = !isValid;
        });
        */

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
                      isLoading: _isLoading,
                      nameController: _nameController,
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
                    DesignSection(textController: _productsController),
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
                              Tab(text: localization.products),
                              //Tab(text: localization.tasks),
                              Tab(text: localization.includes),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                DesignSettings(
                                  isLoading: _isLoading,
                                  nameController: _nameController,
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
                                DesignSection(
                                    textController: _productsController),
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
  const DesignSection({@required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.multiline,
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
    );
  }
}

class DesignSettings extends StatefulWidget {
  const DesignSettings({
    @required this.nameController,
    @required this.onLoadDesign,
    @required this.draftMode,
    @required this.onDraftModeChanged,
    @required this.isLoading,
  });

  final Function(DesignEntity) onLoadDesign;
  final TextEditingController nameController;
  final bool draftMode;
  final bool isLoading;
  final Function(bool) onDraftModeChanged;

  @override
  _DesignSettingsState createState() => _DesignSettingsState();
}

class _DesignSettingsState extends State<DesignSettings> {
  DesignEntity _selectedDesign;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              label: localization.name,
              controller: widget.nameController,
            ),
            DesignPicker(
                label: localization.design,
                onSelected: (value) {
                  widget.onLoadDesign(value);
                  _selectedDesign = value;
                },
                initialValue: _selectedDesign?.id),
            SizedBox(height: 16),
            SwitchListTile(
              activeColor: Theme.of(context).accentColor,
              title: Text(localization.draftMode),
              subtitle: Text(localization.draftModeHelp),
              value: widget.draftMode,
              onChanged: widget.isLoading ? null : widget.onDraftModeChanged,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: OutlineButton(
            child: Text(localization.viewDocs.toUpperCase()),
            onPressed: () =>
                launch('https://invoiceninja.github.io/docs/custom-fields/'),
          ),
        ),
        VariablesHelp(),
      ],
    );
  }
}

class PdfDesignPreview extends StatefulWidget {
  const PdfDesignPreview({
    @required this.pdfBytes,
    @required this.isLoading,
  });

  final Uint8List pdfBytes;

  final bool isLoading;

  @override
  _PdfDesignPreviewState createState() => _PdfDesignPreviewState();
}

class _PdfDesignPreviewState extends State<PdfDesignPreview> {
  PdfController _pdfController;

  String get _pdfString =>
      'data:application/pdf;base64,' + base64Encode(widget.pdfBytes);

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pdfBytes == widget.pdfBytes) {
      return;
    }

    if (kIsWeb) {
      WebUtils.registerWebView(_pdfString);
    } else {
      final document = PdfDocument.openData(widget.pdfBytes);
      if (_pdfController == null) {
        _pdfController = PdfController(document: document);
      } else {
        _pdfController.loadDocument(document);
      }
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (widget.pdfBytes == null)
            SizedBox()
          else if (kIsWeb)
            HtmlElementView(viewType: _pdfString)
          else if (_pdfController != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: PdfView(
                controller: _pdfController,
              ),
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
    @required this.html,
    @required this.isLoading,
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
