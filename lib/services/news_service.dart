import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsService {
  Future<Map<String, dynamic>> fetchNews({
    required int pageSize,
  }) async {
    try {
      final response = await http.get(Uri.parse(
          "https://newsapi.org/v2/everything?q=disaster&apiKey=aca67592169e4d72ab41f4418e1a59ca&pageSize=$pageSize"));

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
