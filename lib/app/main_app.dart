import 'package:flutter/material.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'core/dependency_injection/dependency_injection_inherited_widget.dart';
import 'core/dependency_injection/dependency_injection_initializer.dart';
import 'core/dependency_injection/get_it_dependency_injection_imp.dart';
import 'core/routing/app_router_config.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final Future<DependencyInjection> diFuture;
  RouterConfig<Object>? routerConfig;

  @override
  void initState() {
    super.initState();
    diFuture = DependencyInjectionInitializer.call(GetItDependencyInjection());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DependencyInjection>(
      future: diFuture,
      builder: (context, snapshot) {
        final di = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting || di == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        routerConfig ??= di.get<AppRouterConfig>().config;
        return DependencyInjectionInheritedWidget(
          di: snapshot.data!,
          child: MaterialApp.router(
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.dark,
            routerConfig: routerConfig,
          ),
        );
      },
    );
  }
}
