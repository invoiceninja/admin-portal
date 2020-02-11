import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';

ReportResult clientReport({
  CompanyEntity company,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
}) {
  final List<List<ReportElement>> data = [];

  for (var clientId in clientMap.keys) {
    final client = clientMap[clientId];
    if (client.isDeleted) {
      continue;
    }

    data.add([
      ReportEntityValue(
        entityType: EntityType.client,
        entityId: client.id,
      ),
      ReportValue(
        value: client.state,
      )
    ]);
  }

  return ReportResult(
    columns: [
      ClientFields.name,
      ClientFields.state,
    ],
    data: data,
  );
}


ReportResult invoiceReport({
  CompanyEntity company,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
}) {
  final List<List<ReportElement>> data = [];
  final Map<String, double> totalAmounts = {};
  final Map<String, double> totalPaid = {};

  for (var invoiceId in invoiceMap.keys) {
    final invoice = invoiceMap[invoiceId];
    final client = clientMap[invoice.clientId];

    if (invoice.isDeleted) {
      continue;
    }

    if (invoice.isBetween(
        reportsUIState.startDate(company), reportsUIState.endDate(company))) {
      if (!totalAmounts.containsKey(client.id)) {
        totalAmounts[client.id] = 0;
        totalPaid[client.id] = 0;
      }
      totalAmounts[client.id] += invoice.amount;
      totalPaid[client.id] += invoice.amount - invoice.balance;
    }
  }

  for (var clientId in clientMap.keys) {
    final client = clientMap[clientId];
    if (client.isDeleted) {
      continue;
    }
  }

  return ReportResult(
    columns: [],
    data: data,
  );
}
