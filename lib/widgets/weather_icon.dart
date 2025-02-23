import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/services/weather_icons_mapper.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherIcon extends StatelessWidget {
  final WeatherModel? weatherData;

  const WeatherIcon({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 2000),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Lottie.asset(
        WeatherIconMapper.getWeatherIcon(weatherData?.weatherStateName),
        height: 140,
        width: 140,
        repeat: true,
        frameRate: FrameRate(60),
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.cloud_queue, size: 140, color: Colors.white),
      ),
    );
  }
}
