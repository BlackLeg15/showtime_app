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
  /// Async initialization of the dependency injection service.
  late final Future<DependencyInjection> diFuture;

  /// RouterConfig instance responsible for controlling the
  /// navigation and routes of the app.
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (di == null) {
          return MaterialApp(
            home: Builder(builder: (context) {
              final textTheme = Theme.of(context).textTheme;
              return Center(
                child: Text(
                  'It was not possible to start the app.\nPlease, get in touch with us.\nContact: support@email.com',
                  style: textTheme.titleLarge,
                ),
              );
            }),
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
