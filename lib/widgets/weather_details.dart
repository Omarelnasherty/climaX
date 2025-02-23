import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/custom_widgets/weather_widgets.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherModel? weatherData;

  const WeatherDetails({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.5, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Transform.scale(
            scale: value, child: Opacity(opacity: value, child: child));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white30, width: 1),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
          ],
        ),
        child: Column(
          children: [
            buildWeatherRow([
              buildWeatherDetail(
                  'Feels Like',
                  '${weatherData?.temp?.toInt() ?? 0}°',
                  Icons.thermostat_outlined),
              buildWeatherDetail('Humidity', '${weatherData?.humidity ?? 0}%',
                  Icons.water_drop_outlined),
              buildWeatherDetail(
                  'Wind', '${weatherData?.wind ?? 0} km/h', Icons.air_outlined),
            ]),
            const Divider(color: Colors.white30, height: 24),
            buildWeatherRow([
              buildTemperatureDetail(
                  'Min',
                  '${weatherData?.mintemp?.toInt() ?? 0}°',
                  Icons.arrow_downward),
              buildTemperatureDetail('Max',
                  '${weatherData?.maxtemp?.toInt() ?? 0}°', Icons.arrow_upward),
            ]),
          ],
        ),
      ),
    );
  }
}
