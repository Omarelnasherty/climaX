// ignore_for_file: unused_local_variable, unused_import, non_constant_identifier_names, avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherService {
  String BaseUrl = 'http://api.weatherapi.com/v1';
  String ApiKey = '36308b2da0b24a48bd7192105242710';

  Future<WeatherModel> getWeather({required String CityName}) async {
    Uri url = Uri.parse('$BaseUrl/forecast.json?key=$ApiKey&q=$CityName');
    http.Response response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    var jsonData = data['forecast']['forecastday'][0]['day'];
    WeatherModel weather = WeatherModel.fromJson(data);

    return weather;
  }

  Future<WeatherModel?> getWeatherByLocation(
      double latitude, double longitude) async {
    Uri url =
        Uri.parse('$BaseUrl/forecast.json?key=$ApiKey&q=$latitude,$longitude');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      WeatherModel weather = WeatherModel.fromJson(data);
      return weather;
    } else {
      print('Failed to load weather data');
      return null;
    }
  }
}
