import 'package:get/get.dart';
import 'package:weather/model/lat_lng.dart';
import 'package:weather/model/simple_weather.dart';
import 'package:weather/model/weather_forecast.dart';
import 'package:weather/services/remote_service.dart';

enum UpdateStatus {
  idle,
  updating,
}

class WeatherController extends GetxController {
  final LatLng latLng;
  WeatherController({required this.latLng});

  @override
  void onInit() {
    updateWeather();
    super.onInit();
  }

  void updateWeather() async {
    updateStatus.value = UpdateStatus.updating;
    (await RemoteService.getLatLngWeather(latLng)).fold(
        (l) => updateCurrentCityWeather(l),
        (r) =>
            Get.snackbar(r.message, '', snackPosition: SnackPosition.BOTTOM));
    (await RemoteService.getLatLngForecast(latLng)).fold(
        (l) => updateCurrentCityForecacst(l),
        (r) =>
            Get.snackbar(r.message, '', snackPosition: SnackPosition.BOTTOM));
    updateStatus.value = UpdateStatus.idle;
  }

  var updateStatus = UpdateStatus.idle.obs;

  var currentCityWeather = Rx<SimpleWeather>(
    SimpleWeather(
      dt: 0,
      main: Main(
          temp: 0,
          feelsLike: 0,
          tempMin: 0,
          tempMax: 0,
          pressure: 0,
          humidity: 0,
          seaLevel: 0,
          grndLevel: 0),
      name: '',
      sys: Sys(type: 0, id: 0, country: '', sunrise: 0, sunset: 0),
      wind: Wind(speed: 0, deg: 0, gust: 0),
      weather: [
        Weather(id: 0, main: '', description: 'description', icon: ''),
      ],
    ),
  );

  RxList<WeatherForecast> weatherForercasts = RxList();

  updateCurrentCityForecacst(List<WeatherForecast> newWeatherForecast) {
    weatherForercasts.value = newWeatherForecast;
    weatherForercasts.refresh();
  }

  updateCurrentCityWeather(SimpleWeather newWeather) {
    currentCityWeather.value = newWeather;
    currentCityWeather.refresh();
  }
}
