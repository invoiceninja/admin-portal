import 'clients_it_test.dart' as clients;
import 'invoices_it_test.dart' as invoices;
import 'login_it_test.dart' as login;
import 'products_it_test.dart' as products;

void main() {
  login.main();
  products.runTestSuite(batchMode: true);
  clients.runTestSuite(batchMode: true);
  invoices.runTestSuite(batchMode: true);
}
