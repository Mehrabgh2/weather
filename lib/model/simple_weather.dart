class SimpleWeather {
  List<Weather> weather;
  Main main;
  Wind wind;
  num dt;
  Sys sys;
  String name;

  SimpleWeather(
      {required this.weather,
      required this.main,
      required this.wind,
      required this.dt,
      required this.sys,
      required this.name});

  factory SimpleWeather.fromJson(Map<String, dynamic> json) {
    final List<Weather> weather = List.empty(growable: true);
    if (json['weather'] != null) {
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }
    final main = Main.fromJson(json['main']);
    final wind = Wind.fromJson(json['wind']);
    final dt = json['dt'] ?? 0;
    final sys = Sys.fromJson(json['sys']);
    final name = json['name'] ?? '';
    return SimpleWeather(
        weather: weather, main: main, wind: wind, dt: dt, sys: sys, name: name);
  }
}

class Weather {
  num id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? 0;
    final main = json['main'] ?? '';
    final description = json['description'] ?? '';
    final icon = json['icon'] ?? '';
    return Weather(id: id, main: main, description: description, icon: icon);
  }
}

class Main {
  num temp;
  num feelsLike;
  num tempMin;
  num tempMax;
  num pressure;
  num humidity;
  num seaLevel;
  num grndLevel;

  Main(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity,
      required this.seaLevel,
      required this.grndLevel});

  factory Main.fromJson(Map<String, dynamic> json) {
    final temp = json['temp'] ?? 0.0;
    final feelsLike = json['feels_like'] ?? 0.0;
    final tempMin = json['temp_min'] ?? 0.0;
    final tempMax = json['temp_max'] ?? 0.0;
    final pressure = json['pressure'] ?? 0;
    final humidity = json['humidity'] ?? 0;
    final seaLevel = json['sea_level'] ?? 0;
    final grndLevel = json['grnd_level'] ?? 0;
    return Main(
        temp: temp,
        feelsLike: feelsLike,
        tempMin: tempMin,
        tempMax: tempMax,
        pressure: pressure,
        humidity: humidity,
        seaLevel: seaLevel,
        grndLevel: grndLevel);
  }
}

class Wind {
  num speed;
  num deg;
  num gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    final speed = json['speed'] ?? 0.0;
    final deg = json['deg'] ?? 0;
    final gust = json['gust'] ?? 0.0;
    return Wind(speed: speed, deg: deg, gust: gust.round());
  }
}

class Sys {
  num type;
  num id;
  String country;
  num sunrise;
  num sunset;

  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    final type = json['type'] ?? 0;
    final id = json['id'] ?? 0;
    final country = json['country'] ?? '';
    final sunrise = json['sunrise'] ?? 0;
    final sunset = json['sunset'] ?? 0;
    return Sys(
        type: type, id: id, country: country, sunrise: sunrise, sunset: sunset);
  }
}
