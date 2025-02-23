import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/weather_provider.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/custom_widgets/custom_snackbar.dart';
import 'package:weatherapp/custom_widgets/custom_textfield.dart';
import 'package:weatherapp/custom_widgets/custom_loading_indicator.dart';

class Searchpage extends StatefulWidget {
  final VoidCallback? updateUi;
  const Searchpage({super.key, this.updateUi});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<Searchpage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  final TextEditingController _textController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather(String cityName) async {
    if (cityName.trim().isEmpty) return;

    setState(() => _isLoading = true);
    try {
      WeatherService service = WeatherService();
      WeatherModel weather = await service.getWeather(CityName: cityName);

      if (!mounted) return;

      Provider.of<WeatherProvider>(context, listen: false)
          .setWeatherData(weather);
      Provider.of<WeatherProvider>(context, listen: false)
          .setCityName(cityName);

      showCustomSnackBar(
        context: context,
        message: 'Got it! Fetching the latest weather for you. 🌦️',
        color: const Color(0xFF1E88E5),
        icon: Icons.check_circle,
      );

      Future.delayed(
        const Duration(milliseconds: 800),
        () {
          if (mounted) {
            Navigator.pop(context, true);
          }
        },
      );
    } catch (e) {
      showCustomSnackBar(
        context: context,
        message: "Couldn't find it! Maybe try another planet? 🛸",
        color: const Color(0xFFE65100),
        icon: Icons.error_outline,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          "Find Your City's Weather ☁️",
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF071327), Color(0xFF050A17)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: _textController,
                    onSubmitted: _fetchWeather,
                  ),
                  if (_isLoading) const LoadingIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
