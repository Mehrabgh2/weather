import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/weather_controller.dart';
import 'package:weather/model/lat_lng.dart';
import 'package:weather/services/location_service.dart';
import 'package:weather/widget/weather_card.dart';
import 'package:weather/widget/weather_forecast_listview.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: LocationService().getUserLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Text('LOADING', style: TextStyle(color: Colors.white)));
        } else {
          if (snapshot.hasData) {
            Get.put(WeatherController(latLng: snapshot.data!));
            return Column(
              children: [
                WeatherCard(),
                Expanded(child: WeatherForecastListView()),
              ],
            );
          } else {
            return  Center(
              child: Text('progressing', style: TextStyle(color: Colors.white)));
          }
        }
      },
    );
  }
}
