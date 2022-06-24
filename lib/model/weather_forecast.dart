import 'package:weather/model/simple_weather.dart';

class WeatherForecast {
  WeatherForecast({
    required this.weather,
    required this.main,
    required this.wind,
    required this.dt,
  });
  Weather weather;
  Main main;
  Wind wind;
  num dt;

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final weather = Weather.fromJson(json['weather'][0]);
    final main = Main.fromJson(json['main']);
    final wind = Wind.fromJson(json['wind']);
    final dt = json['dt'] ?? 0;
    return WeatherForecast(weather: weather, main: main, wind: wind, dt: dt);
  }
}
