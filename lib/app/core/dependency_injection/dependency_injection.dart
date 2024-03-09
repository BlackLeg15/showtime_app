/// Class that declares the necessary functions
/// for the app to work with dependency injection.
abstract class DependencyInjection {
  /// Registers a dependency as a Singleton instance
  void registerSingleton<T extends Object>(T object);
  /// Retrieves a dependency
  T get<T extends Object>();
  /// Callable function that's supposed to call the get<T>() function
  T call<T extends Object>();
}
