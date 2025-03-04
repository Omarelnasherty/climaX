import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/weather_provider.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/pages/no_weather_data_page.dart';
import 'package:weatherapp/pages/weather_data_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  NewHomeState createState() => NewHomeState();
}

class NewHomeState extends State<Homepage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // تشغيل الأنيميشن
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<double>(begin: -30, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WeatherModel? weatherData =
        Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      body: weatherData == null
          ? NoWeatherDataPage(
              fadeAnimation: _fadeAnimation,
              slideAnimation: _slideAnimation,
              updateUi: () => setState(() {}),
            )
          : WeatherDataPage(
              weatherData: weatherData,
              updateUi: () => setState(() {}),
            ),
    );
  }
}
