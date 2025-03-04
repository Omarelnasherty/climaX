import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/custom_widgets/custom_snackbar.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weatherData;
  String? _cityName;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get weatherData => _weatherData;
  String? get cityName => _cityName;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeatherDataByLocation(BuildContext context) async {
    _setLoading(true);
    _setError(null);

    try {
      final position = await _getLocation();
      final weatherData = await WeatherService()
          .getWeatherByLocation(position.latitude, position.longitude);

      if (weatherData != null) {
        _setWeatherData(weatherData);
      } else {
        _setError("لم يتم العثور على بيانات الطقس.");
        showCustomSnackBar(
          context: context,
          message: "لم يتم العثور على بيانات الطقس.",
          color: Colors.red,
          icon: Icons.error,
        );
      }
    } catch (e) {
      _setError("حدث خطأ أثناء جلب الموقع ");
      showCustomSnackBar(
        context: context,
        message: "حدث خطأ أثناء جلب الموقع ",
        color: Colors.red,
        icon: Icons.error,
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("خدمة الموقع غير مفعلة. يرجى تفعيلها من الإعدادات.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("تم رفض إذن الوصول للموقع.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("تم رفض إذن الوصول بشكل دائم. يرجى تغييره من الإعدادات.");
    }

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      throw Exception("حدث خطأ أثناء جلب الموقع ");
    }
  }

  void _setWeatherData(WeatherModel weatherData) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _weatherData = weatherData;
      _cityName = weatherData.cityName;
      notifyListeners();
    });
  }

  void setWeatherData(WeatherModel weatherData) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _weatherData = weatherData;
      notifyListeners();
    });
  }

  void setCityName(String cityName) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cityName = cityName;
      notifyListeners();
    });
  }

  void _setLoading(bool value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = value;
      notifyListeners();
    });
  }

  void _setError(String? error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _errorMessage = error;
      notifyListeners();
    });
  }
}
