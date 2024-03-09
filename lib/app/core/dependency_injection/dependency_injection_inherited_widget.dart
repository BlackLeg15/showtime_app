import 'package:flutter/widgets.dart';

import 'dependency_injection.dart';

/// Class that provides the dependency injection feature 
/// (i.e. [DependencyInjection]) for the given widget tree (i.e., [child]).
class DependencyInjectionInheritedWidget extends InheritedWidget {
  /// Dependencies provider.
  /// Call its get<T>() function to get a registered instance of type T.
  final DependencyInjection di;

  ///Creates an [DependencyInjectionInheritedWidget] instance.
  const DependencyInjectionInheritedWidget({super.key, required super.child, required this.di});

  @override
  bool updateShouldNotify(covariant DependencyInjectionInheritedWidget oldWidget) {
    return false;
  }

  /// The [DependencyInjection] from the closest [DependencyInjectionInheritedWidget] 
  /// instance that encloses the given context.
  static DependencyInjection of(BuildContext context) => context.getInheritedWidgetOfExactType<DependencyInjectionInheritedWidget>()!.di;

  /// It retrieves or creates an instance of a registered type [T] depending on the registration
  /// function used for this type or based on a name.
  static T get<T extends Object>(BuildContext context) => of(context)();
}
