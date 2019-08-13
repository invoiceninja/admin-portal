import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';

class MainScreen extends StatelessWidget {
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AppDrawerBuilder(),
        //Expanded(child: DashboardScreen()),
        Expanded(
          flex: 3,
          child: InvoiceScreen(),
        ),
        Expanded(
          flex: 5,
          child: InvoiceEditScreen(),
        ),
      ],
    );
  }
}
