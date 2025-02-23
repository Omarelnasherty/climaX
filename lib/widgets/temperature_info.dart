import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';

class TemperatureInfo extends StatelessWidget {
  final WeatherModel? weatherData;

  const TemperatureInfo({Key? key, required this.weatherData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: Column(
        children: [
          Text('${weatherData?.temp.toInt() ?? 0}°C',
              style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text(weatherData?.weatherStateName ?? 'No weather data',
              style: const TextStyle(fontSize: 24, color: Colors.white70)),
        ],
      ),
    );
  }
}
