import 'package:get_it/get_it.dart';

import 'dependency_injection.dart';

class GetItDependencyInjection implements DependencyInjection {
  @override
  T get<T extends Object>() {
    return GetIt.I<T>();
  }

  @override
  void registerSingleton<T extends Object>(T object) {
    GetIt.I.registerSingleton<T>(object);
  }

  @override
  T call<T extends Object>() => get();

  @override
  void registerFactory<T extends Object>(T Function() factory) {
    GetIt.I.registerFactory<T>(factory);
  }

  @override
  void registerSingletonAsync<T extends Object>(Future<T> Function() function) {
    GetIt.I.registerSingletonAsync(function);
  }

  @override
  Future<T> getAsync<T extends Object>() {
    return GetIt.I.getAsync<T>();
  }

}
