import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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

  // STARTER: controllers - do not remove comment

  FocusScopeNode _focusNode;
  TabController _controller;

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _controller = TabController(
        vsync: this, length: widget.viewModel.state.prefState.isMobile ? 3 : 2);
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final design = widget.viewModel.design;
    // STARTER: read value - do not remove comment

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
          // STARTER: set value - do not remove comment
          );
      if (design != widget.viewModel.design) {
        widget.viewModel.onChanged(design);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final design = viewModel.design;

    return EditScaffold(
        title: localization.editDesign,
        onCancelPressed: (context) => viewModel.onCancelPressed(context),
        appBarBottom: isMobile(context)
            ? TabBar(
                //key: ValueKey(state.settingsUIState.updatedAt),
                controller: _controller,
                tabs: [
                  Tab(
                    text: localization.settings,
                  ),
                  Tab(
                    text: localization.preview,
                  ),
                  Tab(
                    text: localization.header,
                  ),
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
                  DesignSettings(),
                  DesignPreview(),
                  DesignHeader(),
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
                            tabs: <Widget>[
                              Tab(
                                text: localization.settings,
                              ),
                              Tab(
                                text: localization.header,
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _controller,
                              children: <Widget>[
                                DesignSettings(),
                                DesignHeader(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: DesignPreview(),
                    ),
                  ],
                ),
              ));
  }
}

class DesignHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                //scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                autofocus: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DesignSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            AppDropdownButton<String>(
              value: null,
              onChanged: (dynamic value) {},
              items: ['Bootrap']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              labelText: localization.cssFramework,
            ),
            AppDropdownButton<String>(
              value: null,
              onChanged: (dynamic value) {},
              items: ['Bootrap']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              labelText: localization.loadDesign,
            ),
          ],
        ),
      ],
    );
  }
}

class DesignPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
