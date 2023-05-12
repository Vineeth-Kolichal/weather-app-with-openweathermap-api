import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/constants.dart';
import 'package:weather/infrastructure/home_screen/home_screen_implementation.dart';
import 'package:weather/presentation/widgets/custom_appbar.dart';

import 'widgets/weather_details_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {};
  bool isLoading = true;
  int temp = 0;
  int pressure = 0;
  int humidity = 0;
  double windSpeed = 0;
  int cloud = 0;
  Future<void> getData() async {
    data = await getCurrentWeatherData();
    isLoading = data['isLoading'];
    temp = ((data['main'].temp) - 273.15).round();
    pressure = (data['main'].pressure).round();
    humidity = (data['main'].humidity).round();
    windSpeed = (data['wind'].speed);
    cloud = (data['clouds'].all).round();
  }

  @override
  void initState() {
    setState(() {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getData();
      print(data);
      print(isLoading);
    });
    DateTime today = DateTime.now();
    DateFormat formater = DateFormat.yMMMMd();
    String dateToday = formater.format(today);
    Size size = MediaQuery.of(context).size;
    //log(data['name']);
    if (isLoading == true) {
      setState(() {
        getData();
      });
      print(isLoading);
      return Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(), preferredSize: Size.fromHeight(100)),
        body: SafeArea(
            child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )),
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(), preferredSize: Size.fromHeight(100)),
        body: SafeArea(
            child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Text(
                  data['name'] ?? 'Place',
                  style: TextStyle(fontSize: 30),
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
                    style:
                        TextStyle(fontSize: 140, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'o',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Text('C', style: TextStyle(fontSize: 50))
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
                      color: Color.fromARGB(218, 104, 128, 150),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.5, color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      WeatherItemWidget(
                        icon: Icon(Icons.water_drop_outlined),
                        title: 'Humidity',
                        value: '$humidity%',
                      ),
                      Divider(),
                      WeatherItemWidget(
                        icon: Icon(Icons.cloud),
                        title: 'Cloud Cover',
                        value: '$cloud%',
                      ),
                      Divider(),
                      WeatherItemWidget(
                        icon: Icon(Icons.speed),
                        title: 'Pressure',
                        value: '$pressure hPa',
                      ),
                      Divider(),
                      WeatherItemWidget(
                        icon: Icon(CupertinoIcons.speedometer),
                        title: 'Wind Speed',
                        value: '$windSpeed m/s',
                      ),
                    ]),
                  ),
                ),
              ),
            )
          ],
        )),
      );
    }
  }
}
