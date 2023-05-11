import 'package:flutter/material.dart';

class WeatherItemWidget extends StatelessWidget {
  const WeatherItemWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.icon});
  final String title;
  final String value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: icon,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
