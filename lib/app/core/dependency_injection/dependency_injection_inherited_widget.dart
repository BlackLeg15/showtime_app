import 'package:flutter/widgets.dart';

import 'dependency_injection.dart';

class DependencyInjectionInheritedWidget extends InheritedWidget {
  final DependencyInjection di;
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
