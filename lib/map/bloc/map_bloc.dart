import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> getSuggestion(String input) async {
  String kPLACESAPIKEY = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
  List locations = [];
  try {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACESAPIKEY';
    var response = await http.get(Uri.parse(request));
    var data = json.decode(response.body);
    print('mydata');
    print(data);
    if (response.statusCode == 200) {
      locations = json.decode(response.body)['predictions'];
    } else {
      throw Exception('Failed to load predictions');
    }
  } catch (e) {}
  return locations;
}