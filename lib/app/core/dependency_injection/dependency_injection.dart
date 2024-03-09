abstract class DependencyInjection {
  void registerSingleton<T extends Object>(T object);
  T get<T extends Object>();
  T call<T extends Object>();
}
