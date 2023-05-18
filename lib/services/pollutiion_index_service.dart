import 'dart:convert';

import 'package:weatherweather/model.dart/pollution_info.dart';
import 'package:http/http.dart' as http;
import '../theme/constants.dart';

Constants myConstaints = Constants();
Future<PollutionInfo> pollutionService(lat, long) async {
  var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$long&appid=${myConstaints.apiKey}');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    return PollutionInfo.fromJson(jsonDecode(response.body));
  } else
    throw Exception('failed');
}
