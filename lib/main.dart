import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/weather_provider.dart';
import 'package:weatherapp/pages/homepage.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(const Weatherapp());
}

class Weatherapp extends StatelessWidget {
  const Weatherapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) {
        return WeatherProvider();
      },
      child: const MaterialApp(
        home: Homepage(),
      ),
    );
  }
}
