import 'package:flutter/material.dart';

class WeatherIconMapper {
  static String getWeatherIcon(String? condition) {
    if (condition == null) {
      return 'assets/animations/weather_icons/clear-day.json';
    }

    switch (condition.toLowerCase()) {
      case 'clear':
      case 'sunny':
        return 'assets/animations/weather_icons/clear-day.json';

      case 'partly cloudy':
      case 'partly sunny':
      case 'broken clouds':
        return 'assets/animations/weather_icons/partly-cloudy-day.json';

      case 'cloudy':
      case 'overcast':
        return 'assets/animations/weather_icons/cloudy.json';

      case 'rain':
      case 'light rain':
      case 'moderate rain':
      case 'heavy rain':
      case 'showers':
      case 'drizzle':
        return 'assets/animations/weather_icons/rain.json';

      case 'thunderstorm':
      case 'storm':
      case 'thunderstorm with rain':
      case 'severe thunderstorm':
      case 'lightning':
        return 'assets/animations/weather_icons/thunderstorm.json';

      case 'snow':
      case 'light snow':
      case 'moderate snow':
      case 'heavy snow':
      case 'blizzard':
        return 'assets/animations/weather_icons/snow.json';

      case 'fog':
      case 'mist':
      case 'haze':
      case 'smoke':
        return 'assets/animations/weather_icons/fog.json';

      case 'windy':
      case 'breeze':
      case 'strong wind':
      case 'gale':
        return 'assets/animations/weather_icons/windy.json';

      case 'hail':
      case 'sleet':
        return 'assets/animations/weather_icons/hail.json';

      case 'dust':
      case 'sandstorm':
        return 'assets/animations/weather_icons/dust.json';

      default:
        return 'assets/animations/weather_icons/cloudy.json'; // fallback icon
    }
  }

  // Debug method
  static void debugPrintWeatherInfo(String? condition) {
    print('Weather Condition: $condition');
    print('Selected Icon Path: ${getWeatherIcon(condition)}');
  }
}
