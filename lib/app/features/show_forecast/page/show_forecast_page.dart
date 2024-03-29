import 'package:flutter/material.dart';

import '../../../core/entities/city_show_entity.dart';
import '../controller/show_forecast_controller.dart';

/// This page shows a city's current weather plus a 5-day-weather-forecast.
/// As soon as the page is created, it'll call functions to get the current
/// weather and the 5-day forecast weather.
class ShowForecastPage extends StatefulWidget {
  final CityShowEntity cityShowEntity;
  final ShowForecastController controller;

  /// Creates an [ShowForecastPage] instance
  const ShowForecastPage({super.key, required this.cityShowEntity, required this.controller});

  @override
  State<ShowForecastPage> createState() => _ShowForecastPageState();
}

class _ShowForecastPageState extends State<ShowForecastPage> {
  @override
  void initState() {
    widget.controller.getCityCurrentWeather(widget.cityShowEntity);
    widget.controller.getCityForecast(widget.cityShowEntity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final cityName = widget.cityShowEntity.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('$cityName\'s Forecast'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ListenableBuilder(
          listenable: widget.controller,
          builder: (context, child) {
            final currentWeatherException = widget.controller.currentWeatherException;
            final forecastException = widget.controller.forecastException;
            final hasException = currentWeatherException != null || forecastException != null;
            final isLoading = widget.controller.isLoading;
            if (hasException) {
              final exceptionTextTheme = textTheme.titleLarge;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (currentWeatherException != null) ...[
                      Text(
                        currentWeatherException,
                        style: exceptionTextTheme,
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (forecastException != null)
                      Text(
                        forecastException,
                        style: exceptionTextTheme,
                      ),
                  ],
                ),
              );
            }
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final weather = widget.controller.currentWeather!;
            final forecast = widget.controller.forecast;
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    weather.title,
                    style: textTheme.displayLarge,
                  ),
                  Text(
                    weather.description,
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: forecast.length,
                      itemBuilder: (context, index) {
                        final dayForecast = forecast[index];
                        return Column(
                          key: Key('$cityName - ${dayForecast.dateTime}'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              dayForecast.dateTime,
                              style: textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dayForecast.weatherForecasts.length,
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 400,
                                mainAxisExtent: 100,
                              ),
                              itemBuilder: (context, index) {
                                final forecastEntity = dayForecast.weatherForecasts[index];
                                return Wrap(
                                  key: Key('${forecastEntity.id}'),
                                  children: [
                                    Text('Min: ${forecastEntity.tempMin}'),
                                    const SizedBox(width: 10),
                                    Text('Max: ${forecastEntity.tempMax}'),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
