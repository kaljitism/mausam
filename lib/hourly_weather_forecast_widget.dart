import 'package:flutter/material.dart';

class HourlyWeatherForecastWidget extends StatelessWidget {
  const HourlyWeatherForecastWidget({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
  });

  final String time;
  final IconData icon;
  final String temperature;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 120,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              icon,
              size: 25,
            ),
            Text(temperature)
          ],
        ),
      ),
    );
  }
}
