import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  const LocationPage(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Center(
        child: Text('Latitude: $latitude, Longitude: $longitude'),
      ),
    );
  }
}
