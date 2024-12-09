// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/weather_provider.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/pages/searchpage.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void updateUi() {
    setState(() {});
  }

  WeatherModel? WeatherDate;

  @override
  Widget build(BuildContext context) {
    WeatherDate = Provider.of<WeatherProvider>(context).weatherDate;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
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
      body: WeatherDate == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'there is no weather 😔..',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    ' start searshing now 🔍',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Provider.of<WeatherProvider>(context).cityName!,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                      Image.asset('build/images/113.webp'),
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Spacer(
                    flex: 3,
                  )
                ],
              ),
            ),
    );
  }
}
