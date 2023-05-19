import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherweather/theme/constants.dart';

import '../models/weather_info.dart';

Constants myConstaints = Constants();

Future<WeatherInfo> gettingWeatherData(lat, long) async {
  var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&appid=${myConstaints.apiKey}');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else
    throw Exception('failed');
}
