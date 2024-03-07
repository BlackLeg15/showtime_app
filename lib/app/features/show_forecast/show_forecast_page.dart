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
      body: ListenableBuilder(
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
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weather.title,
                  style: textTheme.titleLarge,
                ),
                Text(
                  weather.description,
                  style: textTheme.titleLarge,
                ),
                const Row(
                  children: [],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
