import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/controller/weather_controller.dart';
import 'package:weather/widget/info_card.dart';
import 'dart:math' as math;

class WeatherCard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AnimationController _refreshAnimationController =
        useAnimationController(duration: const Duration(seconds: 2));
    final WeatherController _weatherController = Get.find();
    final _devSize = MediaQuery.of(context).size;
    return Obx(
      () {
        if (_weatherController.updateStatus.value == UpdateStatus.updating) {
          _refreshAnimationController.repeat();
        } else {
          _refreshAnimationController.stop();
        }
        return Container(
          padding: EdgeInsets.all(_devSize.aspectRatio * 10),
          margin: EdgeInsets.only(
              left: _devSize.aspectRatio * 20,
              right: _devSize.aspectRatio * 20,
              top: _devSize.aspectRatio * 55),
          width: double.infinity,
          height: _devSize.height * .41,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1C71F2),
                Color(0xFF074192),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF11489D).withAlpha(75),
                blurRadius: 60.0,
                spreadRadius: 10.0,
                offset: const Offset(
                  0.0,
                  22.5,
                ),
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(_devSize.width * .015),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'London',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: _devSize.width * .045),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      GestureDetector(
                        onTap: () {
                          _weatherController.updateWeather();
                        },
                        child: AnimatedBuilder(
                          animation: _refreshAnimationController,
                          builder: (_, child) {
                            return Transform.rotate(
                              angle: _refreshAnimationController.value *
                                  2 *
                                  math.pi,
                              child: child,
                            );
                          },
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset('assets/rain.json',
                      height: _devSize.height * .23),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Temp',
                        style: GoogleFonts.montserrat(
                            color: Colors.white70,
                            fontSize: _devSize.width * .045),
                      ),
                      Text(
                        '${_weatherController.currentCityWeather.value.main.temp} °C',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: _devSize.width * .085),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(
                      title: 'Humidity',
                      value: _weatherController
                          .currentCityWeather.value.main.humidity
                          .toString(),
                      icon: Icons.water_drop_outlined,
                      sign: '%'),
                  InfoCard(
                      title: 'Pressure',
                      value: _weatherController
                          .currentCityWeather.value.main.pressure
                          .toString(),
                      icon: Icons.adjust_rounded,
                      sign: 'P'),
                  InfoCard(
                      title: 'Wind',
                      value: _weatherController
                          .currentCityWeather.value.wind.speed
                          .toString(),
                      icon: Icons.air,
                      sign: 'km/h'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
