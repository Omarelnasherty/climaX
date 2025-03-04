import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/custom_widgets/custom_button.dart';
import 'package:weatherapp/custom_widgets/custom_loading_animation.dart';
import 'package:weatherapp/custom_widgets/custom_text.dart';
import 'package:weatherapp/pages/searchpage.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/weather_provider.dart';

class NoWeatherDataPage extends StatefulWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;
  final Function updateUi;

  const NoWeatherDataPage({
    super.key,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.updateUi,
  });

  @override
  _NoWeatherDataPageState createState() => _NoWeatherDataPageState();
}

class _NoWeatherDataPageState extends State<NoWeatherDataPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final verticalSpacing = height * 0.03;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF071327), Color(0xFF0B1A38)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: FadeTransition(
                opacity: widget.fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.05),
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.3),
                        end: Offset.zero,
                      ).animate(widget.fadeAnimation),
                      child: CustomText(
                        text: "climaX",
                        fontSize: width * 0.11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: verticalSpacing * 0.5),
                    CustomText(
                      text: "Start your weather journey now",
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Lottie.asset(
                      'assets/animations/location.json',
                      width: width * 0.6,
                      height: width * 0.6,
                      repeat: true,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    CustomButton(
                      icon: Icons.location_on_rounded,
                      text: "Use Current Location",
                      color: Color(0xFF3A6FE9),
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await Provider.of<WeatherProvider>(context,
                                listen: false)
                            .fetchWeatherDataByLocation(context);
                        await Future.delayed(const Duration(seconds: 2));
                        widget.updateUi();
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      width: width,
                    ),
                    SizedBox(height: verticalSpacing * 0.7),
                    CustomButton(
                      icon: Icons.search_rounded,
                      text: "Search for a City",
                      color: Colors.transparent,
                      borderColor: Color(0xFF3A6FE9),
                      textColor: Color(0xFF3A6FE9),
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Searchpage()),
                        );
                        if (result == true) {
                          widget.updateUi();
                        }
                      },
                      width: width,
                    ),
                    SizedBox(height: height * 0.05),
                    CustomText(
                      text: "Weather like never before",
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          CustomLoadingAnimation(
            width: width,
            height: height,
          ),
      ],
    );
  }
}
