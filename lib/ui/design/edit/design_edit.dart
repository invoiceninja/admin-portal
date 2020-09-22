import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_tab_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/designs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

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
  bool _isLoading = false;

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
    _debouncer.run(() {
      final design = widget.viewModel.design.rebuild((b) => b
        ..name = _nameController.text.trim()
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
    final htmlDesign = design.design;
    _headerController.text = htmlDesign[kDesignHeader];
    _bodyController.text = htmlDesign[kDesignBody];
    _footerController.text = htmlDesign[kDesignFooter];
    _productsController.text = htmlDesign[kDesignProducts];
    _tasksController.text = htmlDesign[kDesignTasks];
    _includesController.text = htmlDesign[kDesignIncludes];

    _loadPreview(context, design);
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
        onComplete: (response) async {
          if (!mounted) {
            return;
          }

          setState(() {
            _isLoading = false;
            if (response != null) {
              _pdfBytes = response.bodyBytes;
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final design = viewModel.design;

    return EditScaffold(
        isFullscreen: true,
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
                  Tab(text: localization.header),
                  Tab(text: localization.body),
                  Tab(text: localization.footer),
                  Tab(text: localization.products),
                  //Tab(text: localization.tasks),
                  Tab(text: localization.includes),
                ],
              )
            : null,
        onSavePressed: (context) {
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
                      nameController: _nameController,
                      onLoadDesign: _loadDesign,
                    ),
                    DesignPreview(
                      pdfBytes: _pdfBytes,
                      isLoading: _isLoading,
                    ),
                    DesignSection(textController: _headerController),
                    DesignSection(textController: _bodyController),
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
                              Tab(text: localization.header),
                              Tab(text: localization.body),
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
                                  nameController: _nameController,
                                  onLoadDesign: _loadDesign,
                                ),
                                DesignSection(
                                    textController: _headerController),
                                DesignSection(textController: _bodyController),
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
                      child: DesignPreview(
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
            maxLines: null,
            //autofocus: true,
            style: TextStyle(
              fontFeatures: [FontFeature.tabularFigures()],
              //fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class DesignSettings extends StatelessWidget {
  const DesignSettings({
    @required this.nameController,
    @required this.onLoadDesign,
  });

  final Function(DesignEntity) onLoadDesign;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              label: localization.name,
              controller: nameController,
            ),
            DesignPicker(
              label: localization.loadDesign,
              onSelected: (value) => onLoadDesign(value),
            ),
          ],
        ),
      ],
    );
  }
}

class DesignPreview extends StatefulWidget {
  const DesignPreview({
    @required this.pdfBytes,
    @required this.isLoading,
  });

  final Uint8List pdfBytes;

  final bool isLoading;

  @override
  _DesignPreviewState createState() => _DesignPreviewState();
}

class _DesignPreviewState extends State<DesignPreview> {
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
