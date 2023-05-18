import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weatherweather/theme/constants.dart';

import '../model.dart/weather_info.dart';

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
//we get a string from the get request to the url
//this string is response.body
//we then decode it to a json object [that can be a map or a list or a list of map or map of list whatever] with jsonDecode()
//then we can do whatever we want with that json object