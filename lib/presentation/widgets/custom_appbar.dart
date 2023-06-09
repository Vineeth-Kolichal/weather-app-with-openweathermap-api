import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/infrastructure/home_screen/home_screen_implementation.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Weather today',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              style: const TextStyle(color: Colors.white),
              itemColor: Colors.white,
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
