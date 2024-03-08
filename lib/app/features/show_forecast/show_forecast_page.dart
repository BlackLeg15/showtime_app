import 'package:flutter/material.dart';

import '../../core/entities/city_show_entity.dart';
import 'controller/show_forecast_controller.dart';

class ShowForecastPage extends StatefulWidget {
  final CityShowEntity cityShowEntity;
  final ShowForecastController controller;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.cityShowEntity.name}\'s Forecast'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ListenableBuilder(
          listenable: widget.controller,
          builder: (context, child) {
            final exception = widget.controller.exception;
            final hasException = exception != null;
            final isLoading = widget.controller.isLoading;
            if (hasException) {
              return Center(
                child: Text(exception),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              dayForecast.dateTime.toString(),
                              style: textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   itemCount: dayForecast.forecast.length,
                            //   itemBuilder: (context, index) {
                            //     final forecastEntity = dayForecast.forecast[index];
                            //     return Row(
                            //       children: [
                            //         Text('Min: ${forecastEntity.tempMin.toString()}'),
                            //         const SizedBox(width: 10),
                            //         Text('Max: ${forecastEntity.tempMax.toString()}'),
                            //       ],
                            //     );
                            //   },
                            // ),
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: dayForecast.forecast.length,
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 400,
                                mainAxisExtent: 100,
                              ),
                              itemBuilder: (context, index) {
                                final forecastEntity = dayForecast.forecast[index];
                                return Wrap(
                                  children: [
                                    Text('Min: ${forecastEntity.tempMin.toString()}'),
                                    const SizedBox(width: 10),
                                    Text('Max: ${forecastEntity.tempMax.toString()}'),
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
