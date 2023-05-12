import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather/infrastructure/home_screen/home_screen_implementation.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Weather today',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                onChanged: (value) {
                  getSearchtWeatherData(value);
                },
                backgroundColor: Color.fromARGB(218, 104, 128, 150),
                placeholder: 'Search place',
                placeholderStyle:
                    TextStyle(color: Color.fromARGB(255, 214, 213, 213)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
