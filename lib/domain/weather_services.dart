import 'package:dartz/dartz.dart';
import 'package:weather/domain/failures/main_failure.dart';

abstract class WeatherServices {
  Future<Either<MainFailure, Map<String, dynamic>>> getWeatherData();
  Future<Either<MainFailure, Map<String, dynamic>>> searchtWeatherData(
      {required String searchQuery});
}
