import 'package:flutter/material.dart';
import 'package:mausam/additional_information_widget.dart';
import 'package:mausam/hourly_weather_forecast_widget.dart';
import 'package:mausam/weather_card_widget.dart';

class MausamScreen extends StatelessWidget {
  const MausamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWeatherCard(),
              const SizedBox(height: 20),
              const Text(
                "Weather Forecast",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildWeatherForecastWidget(),
              const SizedBox(height: 20),
              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildAdditionalInformationWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildAdditionalInformationWidget() {
    return const Row(
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
    );
  }

  SingleChildScrollView _buildWeatherForecastWidget() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HourlyWeatherForecastWidget(
            time: "09:00",
            icon: Icons.cloud,
            temperature: "15°C",
          ),
          HourlyWeatherForecastWidget(
            time: "09:00",
            icon: Icons.cloud,
            temperature: "15°C",
          ),
          HourlyWeatherForecastWidget(
            time: "09:00",
            icon: Icons.cloud,
            temperature: "15°C",
          ),
          HourlyWeatherForecastWidget(
            time: "09:00",
            icon: Icons.cloud,
            temperature: "15°C",
          ),
          HourlyWeatherForecastWidget(
            time: "09:00",
            icon: Icons.cloud,
            temperature: "15°C",
          ),
        ],
      ),
    );
  }

  WeatherCard _buildWeatherCard() {
    return const WeatherCard(
      temperature: "15 °C",
      icon: Icons.cloud,
      weather: "Cloudy",
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }
}
