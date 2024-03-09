/// Application's endpoints for http requests
abstract class Endpoints {
  ///Base url to get weather-releated info
  static const openWeather = 'https://api.openweathermap.org/data/2.5';
  ///Route to get a city's current weather
  static const current = '$openWeather/weather';
  ///Route to get a city's 5-day weather forecast
  static const forecast = '$openWeather/forecast';
}
