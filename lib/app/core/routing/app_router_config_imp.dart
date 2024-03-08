import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:showtime_app/app/core/dependency_injection/dependency_injection_inherited_widget.dart';
import 'package:showtime_app/app/core/entities/city_show_entity.dart';
import 'package:showtime_app/app/core/routing/app_router_config.dart';

import '../../features/all_shows/all_shows_page.dart';
import '../../features/show_forecast/show_forecast_page.dart';

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
