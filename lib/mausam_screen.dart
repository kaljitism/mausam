import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mausam/additional_information_widget.dart';
import 'package:mausam/hourly_weather_forecast_widget.dart';
import 'package:mausam/secrets.dart';
import 'package:mausam/weather_card_widget.dart';

class MausamScreen extends StatefulWidget {
  const MausamScreen({super.key});

  @override
  State<MausamScreen> createState() => _MausamScreenState();
}

class _MausamScreenState extends State<MausamScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Kanpur';
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,in&APPID=$openWeatherAPIKey'));
      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        throw 'An Unexpected Error occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  double kelvinToCelsius(double temperatureKelvin) {
    return temperatureKelvin - 273.15;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: FutureBuilder(
            future: getCurrentWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.error.toString()),
                  ),
                );
              }

              final data = snapshot.data!;
              final currentTemperature =
                  kelvinToCelsius(data['list'][0]['main']['temp'])
                      .toStringAsFixed(2);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWeatherCard(currentTemperature),
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
              );
            }),
      ),
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

  WeatherCard _buildWeatherCard(temperature) {
    return WeatherCard(
      temperature: "$temperature °C",
      icon: Icons.cloud,
      weather: "Cloudy",
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
}
