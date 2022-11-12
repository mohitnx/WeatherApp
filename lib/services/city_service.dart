import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weatherweather/model.dart/city_info.dart';
import 'package:http/http.dart' as http;

import '../model.dart/constants.dart';

Constants myConstaints = Constants();

Future<CityInfo> gettingCityData(String cityName, BuildContext context) async {
  var url = Uri.parse(
      'https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=${myConstaints.apiKey}');
  var response = await http.get(url);

  var i;
  if (response.statusCode == 200) {
    i = CityInfo.fromJson(jsonDecode(response.body), context);
  } else
    throw Exception('error');
  return i;
}
