import 'package:flutter/material.dart';
import 'weatherservice.dart'; // Make sure this is correctly named

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  WeatherPageState createState() => WeatherPageState(); // Update here
}

class WeatherPageState extends State<WeatherPage> { // Update here
  late Future<Map<String, dynamic>> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = WeatherService().fetchWeather('Kathmandu'); // Replace with desired city
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: weatherData,
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

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.thermostat,
                  size: 100,
                  color: Colors.red, // Thermometer icon in red color
                ),
                Text(
                  'Temperature: $temperature°C',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Humidity: $humidity%',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Rain Probability: $rain mm', // Adjusting the text to mm for clarity
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
