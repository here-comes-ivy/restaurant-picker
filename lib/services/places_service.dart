import 'package:http/http.dart' as http;
import 'dart:convert';

class PlacesService {
  final String apiKey;
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place';

  PlacesService(this.apiKey);

  Future<Map<String, dynamic>> getRestaurantDetails(String placeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/details/json?place_id=$placeId&fields=name,formatted_phone_number,website&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['result'];
    } else {
      throw Exception('Failed to get restaurant details');
    }
  }
}