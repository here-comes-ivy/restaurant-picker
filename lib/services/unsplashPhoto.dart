import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestaurantList {

  final List<String> restaurants = ['Italian', 'Chinese', 'Mexican', 'Indian'];
  List<String> imageUrls = [];
  bool isLoading = true;


  Future<void> _loadImages() async {
    try {
      for (String restaurant in restaurants) {
        String imageUrl = await getRandomImageUrl('$restaurant restaurant');
        imageUrls.add(imageUrl);
      }

    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<String> getRandomImageUrl(String query) async {
    final apiKey = 'YOUR_UNSPLASH_API_KEY';
    final url = Uri.parse('https://api.unsplash.com/photos/random?query=$query&client_id=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['urls']['regular'];
    } else {
      throw Exception('Failed to load image');
    }
  }
}