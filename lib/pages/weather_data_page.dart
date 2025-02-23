import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/pages/searchpage.dart';
import 'package:weatherapp/widgets/location_info.dart';
import 'package:weatherapp/widgets/date_info.dart';
import 'package:weatherapp/widgets/weather_icon.dart';
import 'package:weatherapp/widgets/temperature_info.dart';
import 'package:weatherapp/widgets/weather_details.dart';

class WeatherDataPage extends StatefulWidget {
  final WeatherModel? weatherData;
  final Function updateUi;

  const WeatherDataPage(
      {Key? key, required this.weatherData, required this.updateUi})
      : super(key: key);

  @override
  State<WeatherDataPage> createState() => _WeatherDataPageState();
}

class _WeatherDataPageState extends State<WeatherDataPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF071327), Color(0xFF0B1A38)],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const LocationInfo(),
            const Spacer(),
            WeatherIcon(weatherData: widget.weatherData),
            const SizedBox(height: 20),
            TemperatureInfo(weatherData: widget.weatherData),
            const SizedBox(height: 8),
            DateInfo(weatherData: widget.weatherData),
            const Spacer(),
            WeatherDetails(weatherData: widget.weatherData),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
