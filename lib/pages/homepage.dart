// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/weather_provider.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/pages/searchpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  NewHomeState createState() => NewHomeState();
}

class NewHomeState extends State<Homepage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<double>(begin: -30, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void updateUi() {
    setState(() {});
  }

  WeatherModel? WeatherDate;

  @override
  Widget build(BuildContext context) {
    WeatherDate = Provider.of<WeatherProvider>(context).weatherDate;
    return Scaffold(
        body: WeatherDate == null
            ? Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF071327), Color(0xFF0B1A38)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, -0.3),
                              end: Offset.zero,
                            ).animate(_animationController),
                            child: Text(
                              "climaX",
                              style: GoogleFonts.roboto(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Lottie.asset(
                            'assets/animations/location_animation.json',
                            width: 160,
                            height: 160,
                            repeat: true,
                          ),
                          const SizedBox(height: 20),
                          Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: Text(
                              "Give your phone a shake and let the magic happen!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "Not a fan of surprises? Type your city and get instant weather updates!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                          const Spacer(),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Searchpage(
                                    updateUi: updateUi,
                                  );
                                }));
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: double.infinity,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.3),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "Check the weather now!",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Searchpage(
                              updateUi: updateUi,
                            );
                          }));
                        },
                        icon: Icon(Icons.search)),
                  ],
                  backgroundColor: Color.fromRGBO(218, 9, 9, 0.927),
                  title: Text('Weather App'),
                ),
                body: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Provider.of<WeatherProvider>(context).cityName!,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'updated:${WeatherDate!.date.toString()}',
                        style: TextStyle(fontSize: 22),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/icon.png'),
                          Text(
                            '${WeatherDate!.temp!.toInt().toString()}',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: [
                              Text('maxTemp: ${WeatherDate!.maxtemp!.toInt()}'),
                              Text('minTemp: ${WeatherDate!.mintemp!.toInt()}')
                            ],
                          )
                        ],
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        WeatherDate?.weatherStateName ?? 'we have erorr',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Spacer(
                        flex: 3,
                      )
                    ],
                  ),
                ),
              ));
  }
}
