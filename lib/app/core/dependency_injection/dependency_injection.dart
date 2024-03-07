abstract class DependencyInjection {
  void registerSingleton<T extends Object>(T object);
  void registerFactory<T extends Object>(T Function() factory);
  T get<T extends Object>();
  T call<T extends Object>();
}
