// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_label, must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/weather_provider.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class Searchpage extends StatelessWidget {
  String? CityName;
  Searchpage({this.updateUi});
  VoidCallback? updateUi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(245, 16, 16, 237),
        title: Text('search a city'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onSubmitted: (data) async {
              CityName = data;

              WeatherService service = WeatherService();
              WeatherModel weather =
                  await service.getWeather(CityName: CityName!);
              Provider.of<WeatherProvider>(context, listen: false).weatherDate =
                  weather;
              Provider.of<WeatherProvider>(context, listen: false).cityName =
                  CityName;
              updateUi!();

              Navigator.pop(context);
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(30),
                suffixIcon: Icon(Icons.search),
                label: Text('search'),
                border: OutlineInputBorder(),
                hintText: 'Enter City Name'),
          ),
        ),
      ),
    );
  }
}
