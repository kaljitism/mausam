import 'package:flutter/material.dart';
import 'package:mausam/additional_information_widget.dart';
import 'package:mausam/hourly_weather_forecast_widget.dart';

class MausamScreen extends StatelessWidget {
  const MausamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mausam",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Card(
                  elevation: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "15 °C",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.cloud,
                            size: 50,
                          ),
                          Text(
                            "Cloudy",
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Weather Forecast",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyWeatherForecastWidget(),
                    HourlyWeatherForecastWidget(),
                    HourlyWeatherForecastWidget(),
                    HourlyWeatherForecastWidget(),
                    HourlyWeatherForecastWidget(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInformationWidget(
                    icon: Icons.water_drop,
                    text: "Humidity",
                    value: "94",
                  ),
                  AdditionalInformationWidget(
                    icon: Icons.air,
                    text: "Wind Speed",
                    value: "7.67",
                  ),
                  AdditionalInformationWidget(
                    icon: Icons.beach_access,
                    text: "Pressure",
                    value: "1006",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
