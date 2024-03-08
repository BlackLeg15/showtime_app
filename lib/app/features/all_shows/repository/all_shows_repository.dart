import 'package:result_dart/result_dart.dart';

import '../../../core/entities/city_show_entity.dart';

abstract class AllShowsRepository {
  AsyncResult<List<CityShowEntity>, Exception> getCities();
}
