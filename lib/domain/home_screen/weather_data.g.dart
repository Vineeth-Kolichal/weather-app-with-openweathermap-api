// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      coord: json['coord'] == null
          ? null
          : Coord.fromJson(json['coord'] as Map<String, dynamic>),
      main: json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      wind: json['wind'] == null
          ? null
          : Wind.fromJson(json['wind'] as Map<String, dynamic>),
      clouds: json['clouds'] == null
          ? null
          : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'main': instance.main,
      'wind': instance.wind,
      'clouds': instance.clouds,
      'name': instance.name,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) => Coord(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

Clouds _$CloudsFromJson(Map<String, dynamic> json) => Clouds(
      all: json['all'] as int?,
    );

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      temp: (json['temp'] as num?)?.toDouble(),
      pressure: json['pressure'] as int?,
      humidity: json['humidity'] as int?,
      seaLevel: json['sea_level'] as int?,
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.seaLevel,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      speed: (json['speed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
    };
