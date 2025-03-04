import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/weather_provider.dart';
import 'package:weatherapp/pages/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // تحديد اتجاه الشاشة ليكون عمودي فقط
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false, // إخفاء شريط الـ debug
        home: Homepage(),
      ),
    );
  }
}
