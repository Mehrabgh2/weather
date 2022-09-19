import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/weather_controller.dart';
import 'package:weather/model/lat_lng.dart';
import 'package:weather/services/location_service.dart';
import 'package:weather/widget/weather_card.dart';
import 'package:weather/widget/weather_forecast_listview.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: LocationService().getUserLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              'LOADING',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          if (snapshot.hasData) {
            Get.put(WeatherController(latLng: snapshot.data!));
            return Column(
              children: const [
                WeatherCard(),
                Expanded(child: WeatherForecastListView()),
              ],
            );
          } else {
            return const Center(
              child: Text(
                'progressing',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        }
      },
    );
  }
}
