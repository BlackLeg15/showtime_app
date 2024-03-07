import 'package:flutter/material.dart';
import 'package:showtime_app/app/core/dependency_injection/dependency_injection.dart';
import 'package:showtime_app/app/core/dependency_injection/dependency_injection_inherited_widget.dart';
import 'package:showtime_app/app/core/dependency_injection/dependency_injection_initializer.dart';
import 'package:showtime_app/app/core/dependency_injection/get_it_dependency_injection_imp.dart';
import 'package:showtime_app/app/core/routing/app_router_config.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final DependencyInjection di;
  late final RouterConfig<Object> routerConfig;

  @override
  void initState() {
    super.initState();
    di = DependencyInjectionInitializer.call(GetItDependencyInjection());
    routerConfig = di.get<AppRouterConfig>().call();
  }

  @override
  Widget build(BuildContext context) {
    return DependencyInjectionInheritedWidget(
      di: di,
      child: MaterialApp.router(
        routerConfig: routerConfig,
      ),
    );
  }
}
