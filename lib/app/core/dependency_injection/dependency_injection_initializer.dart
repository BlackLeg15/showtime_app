import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/all_shows/controller/all_shows_controller.dart';
import '../../features/all_shows/repository/all_shows_repository.dart';
import '../../features/all_shows/repository/all_shows_repository_imp.dart';
import '../../features/show_forecast/controller/show_forecast_controller.dart';
import '../../features/show_forecast/repository/show_forecast_repository.dart';
import '../../features/show_forecast/repository/show_forecast_repository_imp.dart';
import '../http_client/base/http_client.dart';
import '../http_client/dio/dio_http_client.dart';
import '../routing/app_router_config.dart';
import '../routing/app_router_config_imp.dart';
import 'dependency_injection.dart';

/// Class for initializing the app's main dependencies.
class DependencyInjectionInitializer {
  /// Callable function that initializes the app's main dependencies.
  static Future<DependencyInjection> call(DependencyInjection di) async {
    await initializeDateFormatting('pt_BR');
    late final CacheStore cacheStore;
    if (kIsWeb) {
      cacheStore = MemCacheStore();
    } else {
      final tempDir = await getTemporaryDirectory();
      cacheStore = HiveCacheStore(tempDir.path);
    }

    final cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
    );

    di.registerSingleton<AppRouterConfig>(GoRouterRouterConfig());

    di.registerSingleton(Dio()..interceptors.add(DioCacheInterceptor(options: cacheOptions)));
    di.registerSingleton<HttpClient>(DioHttpClient(di()));
    di.registerSingleton<AllShowsRepository>(AllShowsRepositoryImp(di()));
    di.registerSingleton(AllShowsController(di()));

    di.registerSingleton<ShowForecastRepository>(ShowForecastRepositoryImp(di()));
    di.registerSingleton(ShowForecastController(di()));

    return di;
  }
}
