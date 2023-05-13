import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/infrastructure/home_screen/home_screen_implementation.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Weather today',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                InkWell(
                    onTap: () async {
                      await WeatherDataFromApi.getCurrentWeatherData();
                      WeatherDataFromApi.weatherData.value[1].clear();
                    },
                    child: const Icon(Icons.refresh))
              ],
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              onSubmitted: (value) async {
                if (value.isEmpty) {
                  await WeatherDataFromApi.getCurrentWeatherData();
                } else {
                  await WeatherDataFromApi.getSearchtWeatherData(value.trim());
                }
              },
              onChanged: (value) async {
                await WeatherDataFromApi.getCurrentWeatherData();
              },
              backgroundColor: const Color.fromARGB(218, 104, 128, 150),
              placeholder: 'Search place',
              placeholderStyle:
                  const TextStyle(color: Color.fromARGB(255, 214, 213, 213)),
            ),
          )),
        ],
      ),
    );
  }
}
