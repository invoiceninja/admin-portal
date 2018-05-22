import 'dart:async';
import 'dart:core';
import 'package:invoiceninja/redux/auth/auth_state.dart';

import 'package:invoiceninja/data/models/entities.dart';

/// A class that Loads and Persists products. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as products_repository_flutter or products_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class BaseRepository {

  Future<List<dynamic>> loadItems(AuthState auth);

  Future<dynamic> loadItem(AuthState auth);

  Future saveData(List<dynamic> data);
}
