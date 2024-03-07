import 'package:dio/dio.dart';
import 'package:showtime_app/app/core/dependency_injection/dependency_injection.dart';
import 'package:showtime_app/app/core/http_client/dio/dio_http_client.dart';
import 'package:showtime_app/app/core/routing/app_router_config.dart';
import 'package:showtime_app/app/features/all_shows/controller/all_shows_page.dart';
import 'package:showtime_app/app/features/all_shows/repository/all_shows_repository_imp.dart';

import '../../features/all_shows/repository/all_shows_repository.dart';
import '../../features/show_forecast/controller/show_forecast_controller.dart';
import '../../features/show_forecast/repository/show_forecast_repository.dart';
import '../../features/show_forecast/repository/show_forecast_repository_imp.dart';
import '../http_client/base/http_client.dart';
import '../routing/app_router_config_imp.dart';

class DependencyInjectionInitializer {
  static DependencyInjection call(DependencyInjection di) {
    di.registerSingleton<AppRouterConfig>(GoRouterRouterConfig());
    di.registerSingleton(Dio());
    di.registerSingleton<HttpClient>(DioHttpClient(di()));
    di.registerSingleton<AllShowsRepository>(AllShowsRepositoryImp(di()));
    di.registerSingleton(AllShowsController(di()));

    di.registerSingleton<ShowForecastRepository>(ShowForecastRepositoryImp(di()));
    di.registerSingleton(ShowForecastController(di()));

    return di;
  }
}
