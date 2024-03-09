import 'package:result_dart/result_dart.dart';

import '../../../core/entities/city_show_entity.dart';

/// Class that declares the necessary functions
/// for the app to work with a list of cities
abstract class AllShowsRepository {
  /// Function that in fact get a list of cities asynchronously.
  /// If any exceptions happen, a exception is returned.
  /// That function relies on Result pattern.
  AsyncResult<List<CityShowEntity>, Exception> getCities();
}
