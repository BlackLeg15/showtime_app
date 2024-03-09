import 'package:get_it/get_it.dart';

import 'dependency_injection.dart';

/// [DependencyInjection] functionality provided by [GetIt].
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
}
