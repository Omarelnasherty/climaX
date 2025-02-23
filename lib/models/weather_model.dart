class WeatherModel {
  final String cityName;
  final double temp;
  final String weatherStateName;
  final int humidity;
  final double wind;
  final double mintemp;
  final double maxtemp;
  final DateTime date;

  WeatherModel({
    required this.cityName,
    required this.temp,
    required this.weatherStateName,
    required this.humidity,
    required this.wind,
    required this.mintemp,
    required this.maxtemp,
    required this.date,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'],
      temp: json['current']['temp_c'],
      weatherStateName: json['current']['condition']['text'],
      humidity: json['current']['humidity'],
      wind: json['current']['wind_kph'],
      mintemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      maxtemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      date: DateTime.parse(json['location']['localtime']),
    );
  }
}
