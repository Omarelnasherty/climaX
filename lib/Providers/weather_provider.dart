import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weatherData;
  String? _cityName;

  WeatherModel? get weatherDate => _weatherData;
  String? get cityName => _cityName;

  Future<WeatherModel?> fetchWeatherDataByLocation() async {
    try {
      final position = await _getLocation();
      final weatherData = await WeatherService()
          .getWeatherByLocation(position.latitude, position.longitude);
      if (weatherData != null) {
        _cityName = weatherData
            .cityName; // Assuming WeatherModel has a cityName property
        setWeatherData(weatherData);
      }
      return weatherData;
    } catch (e) {
      print('Error fetching weather data: $e');
      return null;
    }
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return an error
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return an error
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, return an error
      throw Exception('Location permissions are permanently denied.');
    }

    // When we reach here, permissions are granted and we can continue
    return await Geolocator.getCurrentPosition();
  }

  void setWeatherData(WeatherModel weatherData) {
    _weatherData = weatherData;
    notifyListeners();
  }

  void setCityName(String cityName) {
    _cityName = cityName;
    notifyListeners();
  }
}
