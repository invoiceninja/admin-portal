import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBuilder extends StatefulWidget {
  const AppBuilder({Key key, this.builder}) : super(key: key);
  final Function(BuildContext) builder;

  @override
  AppBuilderState createState() => new AppBuilderState();

  static AppBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType<AppBuilderState>();
    //return context.ancestorStateOfType(const TypeMatcher<AppBuilderState>());
  }
}

class AppBuilderState extends State<AppBuilder> {
  FocusNode _focusNode;
  String _command = '';

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.requestFocus(null);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void rebuild() {
    setState(() {});
  }

  void runCommand(BuildContext context) {
    print('### RUN COMMAND: $_command ###');
    /*
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.company;
    const force = true;
    dynamic action;

    switch (_command) {
      case 'gd':
        action = ViewDashboard(context: context, force: force);
        break;
      case 'lc':
        action = ViewClientList(force: force);
        break;
      case 'nc':
        action =
            EditClient(client: ClientEntity(), force: force);
        break;
      case 'lr':
        action = ViewProductList(context: context, force: force);
        break;
      case 'nr':
        action = EditProduct(
            context: context, product: ProductEntity(), force: force);
        break;
      case 'li':
        action = ViewInvoiceList(context: context, force: force);
        break;
      case 'ni':
        action = EditInvoice(
            context: context,
            invoice: InvoiceEntity(company: company),
            force: force);
        break;
      case 'lp':
        action = ViewPaymentList(context: context, force: force);
        break;
      case 'np':
        action = EditPayment(
            context: context,
            payment: PaymentEntity(company: company),
            force: force);
        break;
      case 'lq':
        action = ViewQuoteList(context: context, force: force);
        break;
      case 'nq':
        action = EditQuote(
            context: context,
            quote: InvoiceEntity(company: company, isQuote: force));
        break;
      case 'lt':
        action = ViewTaskList(context: context);
        break;
      case 'nt':
        action = EditTask(context: context, task: TaskEntity(), force: force);
        break;
      case 'lv':
        action = ViewVendorList(context: context);
        break;
      case 'nv':
        action =
            EditVendor(context: context, vendor: VendorEntity(), force: force);
        break;
      case 'le':
        viewEntitiesByType(context: context, entityType: EntityType.expense);
        break;
      case 'ne':
        action = EditExpense(
            context: context,
            expense: ExpenseEntity(company: company),
            force: force);
        break;
    }

    if (action != null) {
      store.dispatch(action);
      SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
    }
     */
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      child: widget.builder(context),
      focusNode: _focusNode,
      onKey: (event) {
        if (kReleaseMode) {
          return;
        }
        _command = '';
        /*
        _command += event.logicalKey.keyLabel;
        print(
            'onKey: ${event.logicalKey.keyLabel}, hasFoucs: ${_focusNode.hasFocus}, hasPrimaryFocus: ${_focusNode.hasPrimaryFocus}');
        runCommand(context);
        Timer(Duration(seconds: 1), () => _command = '');
         */
      },
    );
  }
}
