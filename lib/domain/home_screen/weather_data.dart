import 'package:json_annotation/json_annotation.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  Coord? coord;
  Main? main;
  Wind? wind;
  Clouds? clouds;
  String? name;

  WeatherData({this.coord, this.main, this.wind, this.clouds, this.name});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return _$WeatherDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}

@JsonSerializable()
class Coord {
  @JsonKey(name: 'lon')
  double? lon;
  @JsonKey(name: 'lat')
  double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Clouds {
  @JsonKey(name: 'all')
  int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return _$CloudsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Main {
  @JsonKey(name: 'temp')
  double? temp;
  @JsonKey(name: 'pressure')
  int? pressure;
  @JsonKey(name: 'humidity')
  int? humidity;
  @JsonKey(name: 'sea_level')
  int? seaLevel;

  Main({this.temp, this.pressure, this.humidity, this.seaLevel});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Wind {
  @JsonKey(name: 'speed')
  double? speed;

  Wind({this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}
