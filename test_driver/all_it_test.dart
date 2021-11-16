// Project imports:
import 'clients_it_test.dart' as clients;
import 'invoices_it_test.dart' as invoices;
import 'login_it_test.dart' as login;
import 'products_it_test.dart' as products;
import 'quotes_it_test.dart' as quotes;
import 'vendors_it_test.dart' as vendors;

void main() {
  login.main();
  products.runTestSuite(batchMode: true);
  clients.runTestSuite(batchMode: true);
  invoices.runTestSuite(batchMode: true);
  quotes.runTestSuite(batchMode: true);
  vendors.runTestSuite(batchMode: true);
}
