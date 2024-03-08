abstract class DependencyInjection {
  Future<T> getAsync<T extends Object>();
  void registerSingletonAsync<T extends Object>(Future<T> Function() function);
  void registerSingleton<T extends Object>(T object);
  void registerFactory<T extends Object>(T Function() factory);
  T get<T extends Object>();
  T call<T extends Object>();
}
