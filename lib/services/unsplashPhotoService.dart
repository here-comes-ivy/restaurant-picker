import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:math';

class PhotoCreator {

  String ApiKey = dotenv.env['unsplashApiKey']!;


  Future<String?> getRandomImageUrl(String query) async {
 
  var request = http.Request(
    'GET',
    Uri.parse(
        'https://api.unsplash.com/search/photos?query=$query&client_id=$ApiKey&per_page=30')
  );

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String responseBody = await response.stream.bytesToString();
    final data = jsonDecode(responseBody);
    final List<dynamic> results = data['results'];

    if (results.isNotEmpty) {
      final randomIndex = Random().nextInt(results.length);
      final imageUrl = results[randomIndex]['urls']['small'];
      return imageUrl;
    } else {
      print('No images found for the query.');
      return null;
    }
  } else {
    print('Failed to load images: ${response.reasonPhrase}');
    return null;
  }
}
}