import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/constants.dart';
import 'package:weather/infrastructure/home_screen/home_screen_implementation.dart';
import 'package:weather/presentation/widgets/custom_appbar.dart';

import 'widgets/weather_details_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  bool isSearchEmpty = true;
  bool isCurrentEmpty = true;
  @override
  Widget build(BuildContext context) {
    WeatherDataFromApi weather = WeatherDataFromApi();
    // weather.getCurrentWeatherData();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await weather.getCurrentWeatherData();
      isSearchEmpty = weather.searchtData.value.isEmpty;
      isCurrentEmpty = weather.currentData.value.isEmpty;
    });
    DateTime today = DateTime.now();
    DateFormat formater = DateFormat.yMMMMd();
    String dateToday = formater.format(today);
    Size size = MediaQuery.of(context).size;
    log('$isCurrentEmpty,$isSearchEmpty');
    if (isCurrentEmpty && isSearchEmpty) {
      // return Scaffold(
      //   body: Center(
      //     child: CircularProgressIndicator(
      //       strokeWidth: 2,
      //     ),
      //   ),
      // );
    }
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100), child: CustomAppBar()),
      body: SafeArea(
        child: ShowWeatherData(
          valueListenable: weather.currentData,
          weather: weather,
          dateToday: dateToday,
          size: size,
        ),
      ),
    );
  }
}

class ShowWeatherData extends StatelessWidget {
  const ShowWeatherData({
    super.key,
    required this.weather,
    required this.dateToday,
    required this.size,
    required this.valueListenable,
  });
  final ValueNotifier<Map<String, dynamic>> valueListenable;
  final WeatherDataFromApi weather;
  final String dateToday;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, data, _) {
        int temp = 0;
        int pressure = 0;
        int humidity = 0;
        double windSpeed = 0;
        int cloud = 0;
        // bool isLoading = data['isLoading'];
        if (data.isEmpty) {
          return const Center(
              child: SpinKitWave(
            color: Colors.white,
            size: 60.0,
          ));
        } else {
          temp = ((data['main'].temp) - 273.15).round();
          pressure = (data['main'].pressure).round();
          humidity = (data['main'].humidity).round();
          windSpeed = (data['wind'].speed);
          cloud = (data['clouds'].all).round();
          return ListView(
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  Text(
                    data['name'] ?? 'Place',
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
              Center(child: Text(dateToday)),
              kHeight10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$temp',
                      style: const TextStyle(
                          fontSize: 140, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'o',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    const Text('C', style: TextStyle(fontSize: 50))
                  ],
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.95,
                    //height: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(218, 104, 128, 150),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.5, color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        WeatherItemWidget(
                          icon: const Icon(Icons.water_drop_outlined),
                          title: 'Humidity',
                          value: '$humidity%',
                        ),
                        const Divider(),
                        WeatherItemWidget(
                          icon: const Icon(Icons.cloud),
                          title: 'Cloud Cover',
                          value: '$cloud%',
                        ),
                        const Divider(),
                        WeatherItemWidget(
                          icon: const Icon(Icons.speed),
                          title: 'Pressure',
                          value: '$pressure hPa',
                        ),
                        const Divider(),
                        WeatherItemWidget(
                          icon: const Icon(CupertinoIcons.speedometer),
                          title: 'Wind Speed',
                          value: '$windSpeed m/s',
                        ),
                      ]),
                    ),
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
