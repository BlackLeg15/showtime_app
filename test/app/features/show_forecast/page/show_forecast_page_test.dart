import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:showtime_app/app/core/entities/city_show_entity.dart';
import 'package:showtime_app/app/core/entities/current_weather_entity.dart';
import 'package:showtime_app/app/core/entities/day_forecast_entity.dart';
import 'package:showtime_app/app/core/entities/forecast_entity.dart';
import 'package:showtime_app/app/features/show_forecast/controller/show_forecast_controller.dart';
import 'package:showtime_app/app/features/show_forecast/dto/get_current_weather_dto.dart';
import 'package:showtime_app/app/features/show_forecast/dto/get_forecast_dto.dart';
import 'package:showtime_app/app/features/show_forecast/page/show_forecast_page.dart';
import 'package:showtime_app/app/features/show_forecast/repository/show_forecast_repository.dart';

class MockShowForecastRepository extends Mock implements ShowForecastRepository {}

void main() {
  late ShowForecastRepository repository;
  late ShowForecastController controller;
  late CityShowEntity cityShowEntity;

  setUpAll(() {
    repository = MockShowForecastRepository();
    controller = ShowForecastController(repository);
    cityShowEntity = const CityShowEntity(name: 'São Paulo', countryCode: 'BR');
    registerFallbackValue(GetCurrentWeatherDto(cityShowEntity, ''));
    registerFallbackValue(GetForecastDto(cityShowEntity, ''));
  });

  group('ShowForecastPage |', () {
    testWidgets('Empty 5-day-forecast, only current weather', (tester) async {
      when(
        () => repository.getCityCurrentWeather(any()),
      ).thenAnswer((invocation) async => const CurrentWeatherEntity(
            id: 1,
            icon: '10d',
            title: 'Title',
            description: 'Description',
          ).toSuccess());
      when(
        () => repository.getCityForecast(any()),
      ).thenAnswer(
        (invocation) async => <DayForecastEntity>[].toSuccess(),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: ShowForecastPage(cityShowEntity: cityShowEntity, controller: controller),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOne);

      await tester.pump();

      expect(find.text('Title'), findsOne);
      expect(find.text('Description'), findsOne);
    });
    testWidgets('Full 5-day-forecast plus current weather', (tester) async {
      when(
        () => repository.getCityCurrentWeather(any()),
      ).thenAnswer((invocation) async => const CurrentWeatherEntity(
            id: 1,
            icon: '10d',
            title: 'Title',
            description: 'Description',
          ).toSuccess());
      when(
        () => repository.getCityForecast(any()),
      ).thenAnswer(
        (invocation) async => <DayForecastEntity>[
          const DayForecastEntity(
            forecast: [
              ForecastEntity(
                tempMax: 199,
                tempMin: 188,
              ),
            ],
            dateTime: '9 de setembro de 2024',
          ),
        ].toSuccess(),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: ShowForecastPage(cityShowEntity: cityShowEntity, controller: controller),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOne);

      await tester.pump();

      expect(find.text('Title'), findsOne);
      expect(find.text('Description'), findsOne);
      expect(find.text('9 de setembro de 2024'), findsOne);
      expect(controller.forecast.first.forecast.first.tempMin, 188);
      expect(find.text('Min: 188.0'), findsOne);
      expect(find.text('Max: 199.0'), findsOne);
    });
    testWidgets('Exceptions happened', (tester) async {
      const currentWeatherException = 'current-weather-invalid-description';
      const forecastException = 'forecast-date-invalid-response';
      when(
        () => repository.getCityCurrentWeather(any()),
      ).thenAnswer((invocation) async => Exception(currentWeatherException).toFailure());
      when(
        () => repository.getCityForecast(any()),
      ).thenAnswer(
        (invocation) async => Exception(forecastException).toFailure(),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: ShowForecastPage(cityShowEntity: cityShowEntity, controller: controller),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOne);

      await tester.pump();

      expect(find.textContaining(currentWeatherException), findsOne);
      expect(find.textContaining(forecastException), findsOne);
    });
  });
}
