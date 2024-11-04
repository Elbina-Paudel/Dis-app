import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = 'df232d2d276e859b90c44526089488a5';
  static const String _currentUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  // Method to fetch today's weather
  Future<Map<String, dynamic>> fetchCurrentWeather(String cityName) async {
    final response = await http.get(Uri.parse('$_currentUrl?q=$cityName&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load current weather data');
    }
  }

  // Method to fetch 5-day forecast
  Future<List<Map<String, dynamic>>> fetchFiveDayForecast(String cityName) async {
    final response = await http.get(Uri.parse('$_forecastUrl?q=$cityName&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Map<String, dynamic>> forecastList = [];

      for (var item in data['list']) {
        forecastList.add({
          'date': item['dt_txt'],
          'temperature': item['main']['temp'],
          'humidity': item['main']['humidity'],
          'rain': item['rain'] != null ? item['rain']['3h'] : 0.0,
        });
      }

      return forecastList;
    } else {
      throw Exception('Failed to load weather forecast data');
    }
  }
}
