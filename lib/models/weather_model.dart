class WeatherModel {
  String? date;
  double? temp;
  double? maxtemp;
  double? mintemp;
  String? weatherStateName;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxtemp,
      required this.mintemp,
      required this.weatherStateName});

  WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    date = data['location']['localtime'];
    temp = jsonData['avgtemp_c'];
    maxtemp = jsonData['maxtemp_c'];
    mintemp = jsonData['mintemp_c'];
    weatherStateName = jsonData['condition']['text'];
  }
}

@override
String tostring() {
  return 'temp';
}
