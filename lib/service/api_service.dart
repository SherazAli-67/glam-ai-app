import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<void> createImageDescription({
    required String prompt,
    required String imageStyle,
  }) async {
    final String apiKey = dotenv.env['GEMINI_IMAGE_APIKEY']!;
    final String url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';
    final Map<String, dynamic> requestBody = {
      "contents": [
        {
          "parts": [
            {
              "text": "Create an image description for the following prompt in a $imageStyle style: $prompt"
            }
          ]
        }
      ]
    };

    debugPrint("Prompt: $prompt\nStyle: $imageStyle");
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Image Description Response: $data');
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        debugPrint('Body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}