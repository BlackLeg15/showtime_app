import 'package:flutter/widgets.dart';

import 'dependency_injection.dart';

class DependencyInjectionInheritedWidget extends InheritedWidget {
  final DependencyInjection di;
  const DependencyInjectionInheritedWidget({super.key, required super.child, required this.di});

  @override
  bool updateShouldNotify(covariant DependencyInjectionInheritedWidget oldWidget) {
    return false;
  }

  static DependencyInjection of(BuildContext context) => context.getInheritedWidgetOfExactType<DependencyInjectionInheritedWidget>()!.di;
  static T get<T extends Object>(BuildContext context) => of(context)();
}
