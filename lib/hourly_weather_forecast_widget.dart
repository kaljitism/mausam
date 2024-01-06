import 'package:flutter/material.dart';

class HourlyWeatherForecastWidget extends StatelessWidget {
  const HourlyWeatherForecastWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      height: 120,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '09:00',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.cloud,
              size: 25,
            ),
            Text("15°C")
          ],
        ),
      ),
    );
  }
}
