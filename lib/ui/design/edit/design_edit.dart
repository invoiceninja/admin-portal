import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
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
    _controller = TabController(vsync: this, length: 2);
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
                    text: localization.code,
                  ),
                  Tab(
                    text: localization.preview,
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
                children: <Widget>[])
            : AppForm(
                focusNode: _focusNode,
                formKey: _formKey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DesignCode(),
                    ),
                    Expanded(
                      child: DesignPreview(),
                    ),
                  ],
                ),
              ));
  }
}

class DesignCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DesignPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
