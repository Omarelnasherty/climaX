import 'package:flutter/material.dart';
import 'package:weatherapp/custom_widgets/weather_widgets.dart';
import 'package:weatherapp/models/weather_model.dart';

class DateInfo extends StatelessWidget {
  final WeatherModel? weatherData;

  const DateInfo({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.access_time, color: Colors.white70, size: 18),
        const SizedBox(width: 5),
        Text(
          formatDateTime(weatherData?.date),
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }
}
