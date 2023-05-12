import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/application/bloc/home_screen_bloc.dart';
import 'package:weather/core/constants.dart';
import 'package:weather/infrastructure/home_screen/home_screen_repo.dart';
import 'package:weather/presentation/widgets/custom_appbar.dart';

import 'widgets/weather_details_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetWeatherData.internal().getWeatherData();
    });

    DateTime today = DateTime.now();
    DateFormat formater = DateFormat.yMMMMd();
    String dateToday = formater.format(today);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(), preferredSize: Size.fromHeight(100)),
      body: SafeArea(child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state.isLoading) {
            return (Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ));
          } else if (state.hasError) {
            return Center(
              child: Text('Error'),
            );
          }else{
          return ListView(
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
                  kWidth10,
                  Text(
                    state.homeData['name'],
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
                      '20 ',
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
                          value: '20',
                        ),
                        Divider(),
                        WeatherItemWidget(
                          icon: Icon(Icons.cloud),
                          title: 'Cloud Cover',
                          value: '90%',
                        ),
                        Divider(),
                        WeatherItemWidget(
                          icon: Icon(Icons.speed),
                          title: 'Pressure',
                          value: '90%',
                        ),
                        Divider(),
                        WeatherItemWidget(
                          icon: Icon(Icons.height),
                          title: 'Sea Level',
                          value: '90%',
                        ),
                        Divider(),
                        WeatherItemWidget(
                          icon: Icon(CupertinoIcons.speedometer),
                          title: 'Wind Speed',
                          value: '90%',
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
      )),
    );
  }
}
