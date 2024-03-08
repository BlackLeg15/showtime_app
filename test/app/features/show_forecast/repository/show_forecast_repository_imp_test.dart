import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:showtime_app/app/core/entities/city_show_entity.dart';
import 'package:showtime_app/app/core/entities/current_weather_entity.dart';
import 'package:showtime_app/app/core/http_client/base/http_client.dart';
import 'package:showtime_app/app/core/http_client/base/http_client_response.dart';
import 'package:showtime_app/app/features/show_forecast/dto/get_current_weather_dto.dart';
import 'package:showtime_app/app/features/show_forecast/repository/show_forecast_repository.dart';
import 'package:showtime_app/app/features/show_forecast/repository/show_forecast_repository_imp.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late ShowForecastRepository showForecastRepository;
  late GetCurrentWeatherDto correctDto;

  setUpAll(() {
    httpClient = MockHttpClient();
    showForecastRepository = ShowForecastRepositoryImp(httpClient);
    correctDto = const GetCurrentWeatherDto(
      CityShowEntity(name: 'São Paulo', countryCode: 'BR'),
      '123',
    );
    registerFallbackValue(correctDto);
  });

  group('getCityCurrentWeather |', () {
    test('It must get the current weather successfully', () {
      when(() => httpClient.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer(
        (invocation) async => HttpClientResponse(successData, 200, '').toSuccess(),
      );

      final result = showForecastRepository.getCityCurrentWeather(correctDto);

      expect(result.then((value) => value.fold(id, id)), completion(isA<CurrentWeatherEntity>()));
      expect(result.then((value) => value.fold((s) => s.description, id)), completion('moderate rain'));
      expect(result.then((value) => value.fold((s) => s.title, id)), completion('Rain'));
      expect(result.then((value) => value.fold((s) => s.icon, id)), completion('10d'));
      expect(result.then((value) => value.fold((s) => s.id, id)), completion(501));
    });
    test('If id is missing, it should get an exception', () {
      when(() => httpClient.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer(
        (invocation) async => HttpClientResponse(missingIdData, 200, '').toSuccess(),
      );

      final result = showForecastRepository.getCityCurrentWeather(correctDto);

      expect(result.then((value) => value.fold(id, id)), completion(isA<Exception>()));
      expect(result.then((value) => value.fold(id, (f) => f.toString())), completion(contains('current-weather-invalid-id')));
    });
  });
}

const successData = {
  "weather": [
    {"id": 501, "main": "Rain", "description": "moderate rain", "icon": "10d"}
  ],
};

const missingIdData = {
  "weather": [
    {"main": "Rain", "description": "moderate rain", "icon": "10d"}
  ],
};
