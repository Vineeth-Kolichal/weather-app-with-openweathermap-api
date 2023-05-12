import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/core/get_location/get_location.dart';
import 'package:weather/domain/failures/main_failure.dart';
import 'package:weather/domain/weather_data/weather_data.dart';
import 'package:weather/domain/weather_services.dart';
import 'package:weather/infrastructure/api_key.dart';

@LazySingleton(as: WeatherServices)
class GetWeatherData implements WeatherServices {
  GetWeatherData.internal();
  static GetWeatherData instace = GetWeatherData.internal();
  GetWeatherData factory() {
    return instace;
  }

  @override
  Future<Either<MainFailure, Map<String, dynamic>>> getWeatherData() async {
    try {
      Dio dio =
          Dio(BaseOptions(baseUrl: 'https://api.openweathermap.org/data/2.5'));
      Position position = await determinePosition();

      final Response response = await dio.get(
          '/weather?lat=9.936811&lon=76.323204&appid=$apiKey',
          queryParameters: {
            "lat": position.latitude,
            "lon": position.longitude
          });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resp = response.data;
        final result = WeatherData.fromJson(resp);
        Map<String, dynamic> resultToUi = {
          "main": result.main,
          "coord": result.coord,
          "name": result.name,
          "wind": result.wind,
          "clouds": result.clouds
        };
        print(resultToUi);
        return Right(resultToUi);
      } else {
        return const Left(MainFailure.clientFailure());
      }
    } catch (e) {
      return const Left(MainFailure.serverFailure());
    }
  }

  @override
  Future<Either<MainFailure, Map<String, dynamic>>> searchtWeatherData(
      {required String searchQuery}) {
    // TODO: implement searchtWeatherData
    throw UnimplementedError();
  }
}
