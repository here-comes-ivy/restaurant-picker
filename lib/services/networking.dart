import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHelper {
  NetworkHelper(this.url);
  final url;

  Future getRestaurantData () async{  

    http.Response response = await http.get (url);

    if (response.statusCode == 200) {
        var decodedWeatherData = json.decode(response.body);
        return decodedWeatherData;

    } else {
        print("Error getting restaurant data: ${response.statusCode}");
    }
  }


}