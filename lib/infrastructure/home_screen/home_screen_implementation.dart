import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/location/get_locaton.dart';
import 'package:weather/domain/weather_data/weather_data.dart';
import 'package:weather/infrastructure/api_key.dart';

class WeatherDataFromApi extends ChangeNotifier {
  ValueNotifier<Map<String, dynamic>> currentData = ValueNotifier({});
  ValueNotifier<Map<String, dynamic>> searchtData = ValueNotifier({});
  Future<void> getCurrentWeatherData() async {
    log('message');
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
        currentData.value.addAll(resultToUi);
        currentData.notifyListeners();
      } else {
        log('else');

        currentData.value.addAll({});
        currentData.notifyListeners();
      }
    } catch (e) {
      print(e);
      log('catch');

      currentData.value.addAll({});
      currentData.notifyListeners();
    }
  }

  Future<void> getSearchtWeatherData(String place) async {
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
