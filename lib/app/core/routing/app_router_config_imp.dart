import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/all_shows/page/all_shows_page.dart';
import '../../features/show_forecast/page/show_forecast_page.dart';
import '../dependency_injection/dependency_injection_inherited_widget.dart';
import '../entities/city_show_entity.dart';
import 'app_router_config.dart';

class GoRouterRouterConfig implements AppRouterConfig {
  @override
  RouterConfig<Object> config = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => AllShowsPage(
          controller: DependencyInjectionInheritedWidget.get(context),
        ),
      ),
      GoRoute(
        path: '/forecast',
        builder: (context, state) {
          final extra = state.extra;
          if (extra is CityShowEntity) {
            return ShowForecastPage(
              cityShowEntity: extra,
              controller: DependencyInjectionInheritedWidget.get(context),
            );
          }
          return ErrorWidget(Exception('Couldn\'t find CityShowEntity object'));
        },
      ),
    ],
  );
}
