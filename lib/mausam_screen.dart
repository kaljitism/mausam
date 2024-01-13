import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mausam/additional_information_widget.dart';
import 'package:mausam/secrets.dart';
import 'package:mausam/weather_card_widget.dart';
import 'package:mausam/weather_forecast_widget.dart';

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

  double kelvinToCelsius(num temperatureKelvin) {
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
              final currentWeatherData = data['list'][0];
              final currentTemperature =
                  kelvinToCelsius(currentWeatherData['main']['temp'])
                      .toStringAsFixed(2);
              final currentSky = currentWeatherData['weather'][0]['main'];
              final currentPressure = currentWeatherData['main']['pressure'];
              final currentHumidity = currentWeatherData['main']['humidity'];
              final currentWindSpeed = currentWeatherData['wind']['speed'];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWeatherCard(
                      currentTemperature,
                      currentSky,
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
                    _buildWeatherForecastWidget(data),
                    const SizedBox(height: 20),
                    const Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildAdditionalInformationWidget(
                      currentHumidity,
                      currentWindSpeed,
                      currentPressure,
                    ),
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
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {});
          },
        ),
      ],
    );
  }

  WeatherCard _buildWeatherCard(temperature, weather) {
    return WeatherCard(
      temperature: "$temperature °C",
      icon:
          weather == 'Clouds' || weather == 'Rain' ? Icons.cloud : Icons.sunny,
      weather: weather,
    );
  }

  Widget _buildWeatherForecastWidget(data) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 9,
        itemBuilder: (context, index) {
          final hourlyForecast = data['list'][index + 1];
          return WeatherForecastWidget(
            time: hourlyForecast['dt_txt'].toString().substring(11, 16),
            icon: hourlyForecast['weather'][0]['main'] == 'Clouds' ||
                    hourlyForecast['weather'][0]['main'] == 'Rain'
                ? Icons.cloud
                : Icons.sunny,
            temperature: kelvinToCelsius(hourlyForecast['main']['temp'])
                .toStringAsFixed(2),
          );
        },
      ),
    );
  }

  Row _buildAdditionalInformationWidget(humidity, windSpeed, pressure) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AdditionalInformationWidget(
          icon: Icons.water_drop,
          text: "Humidity",
          value: humidity.toString(),
        ),
        AdditionalInformationWidget(
          icon: Icons.air,
          text: "Wind Speed",
          value: windSpeed.toString(),
        ),
        AdditionalInformationWidget(
          icon: Icons.beach_access,
          text: "Pressure",
          value: pressure.toString(),
        ),
      ],
    );
  }
}
