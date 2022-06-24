import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/weather_controller.dart';

class ForecastTile extends StatelessWidget {
  int index;
  ForecastTile({required this.index});
  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;
    final WeatherController _weatherController = Get.find();
    return Obx(
      () => _weatherController.weatherForercasts.value.length > 0
          ? Container(
              color: Colors.amber,
              height: _devSize.height * .2,
              width: double.infinity,
              child: Text(_weatherController.weatherForercasts.value
                  .elementAt(index)
                  .main
                  .humidity
                  .toString()),
            )
          : Container(),
    );
  }
}
