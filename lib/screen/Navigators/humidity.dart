import 'package:flutter/material.dart';
import 'weatherservice.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  late Future<Map<String, dynamic>> currentWeatherData;
  late Future<List<Map<String, dynamic>>> forecastData;

  @override
  void initState() {
    super.initState();
    currentWeatherData = WeatherService().fetchCurrentWeather('Kathmandu'); // Replace with desired city
    forecastData = WeatherService().fetchFiveDayForecast('Kathmandu'); // Replace with desired city
  }

  String getDangerStatus(double rainfall) {
    if (rainfall < 2) {
      return 'Low Risk';
    } else if (rainfall < 10) {
      return 'Medium Risk';
    } else {
      return 'High Risk';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Today’s Weather',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: currentWeatherData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('No data available');
                }

                final data = snapshot.data!;
                final temperature = data['main']['temp'];
                final humidity = data['main']['humidity'];
                final rain = data['rain'] != null ? data['rain']['1h'] : 0.0;
                final dangerStatus = getDangerStatus(rain);

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Temperature: $temperature°C',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Humidity: $humidity%',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rain: $rain mm',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Danger Status: $dangerStatus',
                        style: TextStyle(
                          fontSize: 18,
                          color: dangerStatus == 'High Risk' ? Colors.red :
                                 dangerStatus == 'Medium Risk' ? Colors.orange : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(thickness: 2, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              '5-Day Weather Forecast',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: forecastData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                }

                final data = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final forecast = data[index];
                    final date = forecast['date'];
                    final temperature = forecast['temperature'];
                    final humidity = forecast['humidity'];
                    final rain = forecast['rain'];
                    final dangerStatus = getDangerStatus(rain);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: const Icon(
                          Icons.wb_sunny,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Date: $date',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Temperature: $temperature°C'),
                            Text('Humidity: $humidity%'),
                            Text('Rain: $rain mm'),
                            Text(
                              'Danger Status: $dangerStatus',
                              style: TextStyle(
                                color: dangerStatus == 'High Risk' ? Colors.red :
                                       dangerStatus == 'Medium Risk' ? Colors.orange : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
