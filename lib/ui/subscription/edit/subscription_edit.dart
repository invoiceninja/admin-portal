import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/subscription/edit/subscription_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class SubscriptionEdit extends StatefulWidget {
  const SubscriptionEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final SubscriptionEditVM viewModel;

  @override
  _SubscriptionEditState createState() => _SubscriptionEditState();
}

class _SubscriptionEditState extends State<SubscriptionEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: '_subscriptionEdit');
  final _debouncer = Debouncer();

  // STARTER: controllers - do not remove comment
final _subscriptionsController = TextEditingController();


  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      // STARTER: array - do not remove comment
_subscriptionsController,

    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final subscription = widget.viewModel.subscription;
    // STARTER: read value - do not remove comment
_subscriptionsController.text = subscription.subscriptions;


    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    _debouncer.run(() {

    final subscription = widget.viewModel.subscription.rebuild((b) => b
      // STARTER: set value - do not remove comment
..subscriptions = _subscriptionsController.text.trim()

    );
    if (subscription != widget.viewModel.subscription) {
        widget.viewModel.onChanged(subscription);
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final subscription = viewModel.subscription;

    return EditScaffold(
      title: subscription.isNew ? localization.newSubscription : localization.editSubscription,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
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
      body:Form(
                       key: _formKey,
                       child: Builder(builder: (BuildContext context) {
                         return ScrollableListView(
                           children: <Widget>[
                             FormCard(
                               children: <Widget>[
                                 // STARTER: widgets - do not remove comment
TextFormField(
controller: _subscriptionsController,
autocorrect: false,
decoration: InputDecoration(
labelText: 'Subscriptions',
),
),

                               ],
                             ),
                           ],
                         );
                       })
                   ),

    );
  }
}
