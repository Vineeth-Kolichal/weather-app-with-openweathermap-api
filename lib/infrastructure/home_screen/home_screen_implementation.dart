import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/location/get_locaton.dart';
import 'package:weather/domain/weather_data/weather_data.dart';
import 'package:weather/infrastructure/api_key.dart';

class WeatherDataFromApi extends ChangeNotifier {
  static ValueNotifier<List<Map<String, dynamic>>> weatherData =
      ValueNotifier([]);
  
  static Future<void> getCurrentWeatherData() async {
    try {
      Dio dio =
          Dio(BaseOptions(baseUrl: 'https://api.openweathermap.org/data/2.5'));
      Position position = await determinePosition();

      final Response response = await dio.get('/weather?&appid=$apiKey',
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
          "clouds": result.clouds,
          "isLoading": false
        };
        List<Map<String, dynamic>> data = [resultToUi, {}];
        weatherData.value.addAll(data);
        weatherData.notifyListeners();
     
      } else {
        log('else');

        weatherData.value.addAll([{},{}]);
        weatherData.notifyListeners();
      }
    } catch (e) {
      print(e);
      log('catch');

     weatherData.value.addAll([{},{}]);
        weatherData.notifyListeners();
    }
  }

  static Future<void> getSearchtWeatherData(String place) async {
    try {
      Dio dio =
          Dio(BaseOptions(baseUrl: 'https://api.openweathermap.org/data/2.5'));

      final Response response = await dio
          .get('/weather?&appid=$apiKey', queryParameters: {"q": place});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resp = response.data;
        final result = WeatherData.fromJson(resp);
        Map<String, dynamic> resultToUi = {
          "main": result.main,
          "coord": result.coord,
          "name": result.name,
          "wind": result.wind,
          "clouds": result.clouds,
          "isLoading": false
        };
        print(result.name);
      } else {
        log('else');
        Map<String, dynamic> data = {
          "main": null,
          "coord": null,
          "name": null,
          "wind": null,
          "clouds": null,
          "isLoading": true
        };
      }
    } catch (e) {
      print(e);
      log('catch');
      Map<String, dynamic> data = {
        "main": null,
        "coord": null,
        "name": null,
        "wind": null,
        "clouds": null,
        "isLoading": true
      };
    }
  }
}
