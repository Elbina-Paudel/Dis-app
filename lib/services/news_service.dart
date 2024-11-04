import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<Map<String, dynamic>> fetchNews({
    required int pageSize,
  }) async {
    try {
      final newsApiKey = dotenv.env['NEWS_API_KEY'];
      final response = await http.get(Uri.parse(
          "https://newsapi.org/v2/everything?q=disaster&apiKey=$newsApiKey&pageSize=$pageSize"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data;
      } else {
        return {"message": "Something went wrong"};
      }
    } catch (error) {
      throw '$error';
    }
  }
}
