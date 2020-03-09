import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/designs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

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
  final _debouncer = Debouncer();

  final _nameController = TextEditingController();
  final _headerController = TextEditingController();
  final _footerController = TextEditingController();
  final _bodyController = TextEditingController();
  final _productsController = TextEditingController();
  final _tasksController = TextEditingController();
  final _includesController = TextEditingController();

  FocusScopeNode _focusNode;
  TabController _controller;
  PDFPageImage _pdfPageImage;

  List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _controller = TabController(
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
    _headerController.text = design.getSection(kDesignHeader); //design.design;
    _footerController.text = design.getSection(kDesignFooter); //design.design;
    _bodyController.text = design.getSection(kDesignBody); //design.design;
    _productsController.text =
        design.getSection(kDesignProducts); //design.design;
    _tasksController.text = design.getSection(kDesignTasks);
    _includesController.text = design.getSection(kDesignIncludes);

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
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
    _bodyController.text = htmlDesign[kDesignHeader];
    _footerController.text = htmlDesign[kDesignFooter];
    _productsController.text = htmlDesign[kDesignProducts];
    _tasksController.text = htmlDesign[kDesignTasks];
    _includesController.text = htmlDesign[kDesignIncludes];

    _loadPreview(context, design);
  }

  void _loadPreview(BuildContext context, DesignEntity design) async {
    print('## _loadDesign');

    loadDesign(
        context: context,
        design: design,
        onStart: (value) {
          print('## START: $value');
        },
        onComplete: (response) async {
          print('## START: $response');

          //final bytes = await consolidateHttpClientResponseBytes(value);
          final document = await PDFDocument.openData(response.bodyBytes);

          final page = await document.getPage(1);
          final pageImage = await page.render(width: page.width, height: page.height);
          page.close();

          setState(() {
            _pdfPageImage = pageImage;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final design = viewModel.design;

    return EditScaffold(
        title: design.isNew ? localization.newDesign : localization.editDesign,
        onCancelPressed: (context) => viewModel.onCancelPressed(context),
        appBarBottom: isMobile(context)
            ? TabBar(
                //key: ValueKey(state.settingsUIState.updatedAt),
                controller: _controller,
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
                tabController: _controller,
                formKey: _formKey,
                focusNode: _focusNode,
                children: <Widget>[
                    DesignSettings(
                      nameController: _nameController,
                      onLoadDesign: _loadDesign,
                    ),
                    DesignPreview(_pdfPageImage),
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
                          TabBar(
                            controller: _controller,
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
                              controller: _controller,
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
                      child: DesignPreview(_pdfPageImage),
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
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: textController,
              keyboardType: TextInputType.multiline,
              maxLines: 99999,
              autofocus: true,
            )
          ],
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
    final store = StoreProvider.of<AppState>(context);
    final designState = store.state.designState;

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

class DesignPreview extends StatelessWidget {

  const DesignPreview(this.pdfPageImage);
  final PDFPageImage pdfPageImage;

  @override
  Widget build(BuildContext context) {
    if (pdfPageImage == null) {
      return Container();
    }

    return ExtendedImage.memory(
      pdfPageImage.bytes,
      fit: BoxFit.fitHeight,
    );
  }
}
