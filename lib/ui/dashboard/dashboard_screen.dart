import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';

class DashboardScreen extends StatelessWidget {

  static const String route = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return DashboardBuilder();

    /*
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).dashboard),
      ),
      drawer: AppDrawerBuilder(),
      body: DashboardBuilder(),
    );
    */
  }
}
