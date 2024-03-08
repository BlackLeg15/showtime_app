import 'package:result_dart/result_dart.dart';

import '../../../core/constants/cities.dart';
import '../../../core/entities/city_show_entity.dart';
import '../../../core/http_client/base/http_client.dart';
import 'all_shows_mapper.dart';
import 'all_shows_repository.dart';

class AllShowsRepositoryImp implements AllShowsRepository {
  final HttpClient httpClient;

  AllShowsRepositoryImp(this.httpClient);

  @override
  AsyncResult<List<CityShowEntity>, Exception> getCities() async {
    return AllShowsMapper.fromCityListResponse(defaultCities);
  }
}
