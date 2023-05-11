import 'package:flutter/material.dart';
import 'package:weather/presentation/home_screen/home_screen.dart';

void main(List<String> args) {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(218, 144, 174, 202),
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }
}
