import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/weather_provider.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:
          'location_${Provider.of<WeatherProvider>(context).cityName ?? "location"}',
      child: Text(
        Provider.of<WeatherProvider>(context).cityName ?? 'Unknown Location',
        style: const TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
