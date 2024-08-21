import 'package:http/http.dart' as http;
import 'dart:convert';

textSearch(String queryValue) async {
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'YOUR_API_KEY',
      'X-Goog-FieldMask':
          'places.displayName,places.name,places.id,places.formattedAddress'
    };
    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:searchText'));
    request.body = json.encode({"textQuery": queryValue});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      // do something with the result
    } else {
      print(response.reasonPhrase);
    }
  }