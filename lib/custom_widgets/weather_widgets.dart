import 'package:flutter/material.dart';

Widget buildTemperatureDetail(String label, String temp, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: Colors.white70, size: 20),
      SizedBox(width: 6),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: Colors.white70)),
          Text(temp,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    ],
  );
}

Widget buildWeatherDetail(String label, String value, IconData icon) {
  return Column(
    children: [
      Icon(icon, color: Colors.white70, size: 24),
      SizedBox(height: 8),
      Text(value,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      Text(label, style: TextStyle(fontSize: 13, color: Colors.white70)),
    ],
  );
}

Widget buildWeatherRow(List<Widget> children) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: children,
  );
}

String formatDateTime(DateTime? date) {
  if (date == null) return 'N/A';
  return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} - ${date.day}/${date.month}/${date.year}';
}
