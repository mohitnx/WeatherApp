import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherweather/theme/constants.dart';

Constants myConstaints = Constants();

Future gettingFiveDayData(lat, long) async {
  var json;

  var url = Uri.parse(
      'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&units=metric&appid=${myConstaints.apiKey}');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    json = jsonDecode(response.body);
  } else {
    throw Exception('failed');
  }
  return json;
}
