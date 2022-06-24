import 'dart:convert';
import 'package:weather/model/lat_lng.dart';
import 'package:weather/model/server_response.dart';
import 'package:weather/model/simple_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:weather/model/weather_forecast.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static const String OPEN_WEATHER_MAP_TOKEN =
      'b1b15e88fa797225412429c1c50c122a1';
  static const String BASE_URL = 'https://pro.openweathermap.org/data/2.5';

  static Future<Either<SimpleWeather, ServerResponse>> getLatLngWeather(
      LatLng latLng) async {
    try {
      Uri uri = Uri.parse(
          "$BASE_URL/weather?appid=$OPEN_WEATHER_MAP_TOKEN&lat=${latLng.lat}&lon=${latLng.lng}&units=metric");
      var response = await http.get(
        uri,
      );
      if (response.statusCode == 200) {
        return Left(SimpleWeather.fromJson(jsonDecode(response.body)));
      } else {
        return Right(ServerResponse.fromJson(jsonDecode(response.body)));
      }
    } catch (ex) {
      return Right(ServerResponse(cod: 0, message: 'Something went wrong'));
    }
  }

  static Future<Either<List<WeatherForecast>, ServerResponse>>
      getLatLngForecast(LatLng latLng) async {
    try {
      Uri uri = Uri.parse(
          "$BASE_URL/forecast/hourly?appid=$OPEN_WEATHER_MAP_TOKEN&lat=${latLng.lat},lon=${latLng.lng}&units=metric");
      var response = await http.get(
        uri,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Left(List.generate(data['list'].length,
            (index) => WeatherForecast.fromJson(data['list'][index])));
      } else {
        return Right(ServerResponse.fromJson(jsonDecode(response.body)));
      }
    } catch (ex) {
      return Right(ServerResponse(cod: 0, message: 'Something went wrong'));
    }
  }
}
