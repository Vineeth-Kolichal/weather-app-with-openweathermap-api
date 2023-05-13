import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/constants.dart';
import 'package:weather/infrastructure/home_screen/home_screen_implementation.dart';
import 'package:weather/presentation/widgets/custom_appbar.dart';

import 'widgets/weather_details_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (WeatherDataFromApi.weatherData.value.isEmpty) {
        await WeatherDataFromApi.getCurrentWeatherData();
      }
    });
    DateTime today = DateTime.now();
    DateFormat formater = DateFormat.yMMMMd();
    String dateToday = formater.format(today);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100), child: CustomAppBar()),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await WeatherDataFromApi.getCurrentWeatherData();
          },
          child: ShowWeatherData(
            dateToday: dateToday,
            size: size,
          ),
        ),
      ),
    );
  }
}

class ShowWeatherData extends StatelessWidget {
  const ShowWeatherData({
    super.key,
    required this.dateToday,
    required this.size,
  });

  final String dateToday;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: WeatherDataFromApi.weatherData,
      builder: (context, data, _) {
        int temp = 0;
        int pressure = 0;
        int humidity = 0;
        double windSpeed = 0;
        int cloud = 0;
        if (data.isEmpty || (data[0].isEmpty && data[1].isEmpty)) {
          return const Center(
            child: SpinKitWave(
              color: Colors.white,
              size: 60.0,
            ),
          );
        } else {
          log('$data');
          int i = 0;
          if (data[1].isNotEmpty) {
            i = 1;
          }
          temp = ((data[i]['main'].temp) - 273.15).round();
          pressure = (data[i]['main'].pressure).round();
          humidity = (data[i]['main'].humidity).round();
          windSpeed = (data[i]['wind'].speed);
          cloud = (data[i]['clouds'].all).round();
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
                  ),
                  Text(
                    data[i]['name'] ?? 'Place',
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
