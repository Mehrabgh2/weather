import 'package:flutter/cupertino.dart';
import 'package:weather/widget/forecast_tile.dart';

class WeatherForecastListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ForecastTile(
          index: index,
        );
      },
    );
  }
}
