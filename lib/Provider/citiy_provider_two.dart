import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weatherweather/Pages/snackbar.dart';
import 'package:weatherweather/model.dart/city_info.dart';
import 'package:weatherweather/model.dart/five_day_forcast.dart';
import 'package:weatherweather/model.dart/pollution_info.dart';
import 'package:weatherweather/model.dart/weather_info.dart';
import 'package:weatherweather/services/city_service.dart';
import 'package:weatherweather/services/five_day_service.dart';
import 'package:weatherweather/services/pollutiion_index_service.dart';

import '../services/weather_services.dart';

class CityProvider2 extends ChangeNotifier {
  bool isClicked = false;
  CityInfo? cityInfo;
  WeatherInfo? weatherInfo;
  PollutionInfo? pollutionInfo;
  List<FiveDayForcastData> fiveDayData = [];

  List<double> minTemp = [];
  List<String> iconString = [];
  List<DateTime> time = [];
  List<String> day = [];
  List<String> date = [];
  //date chnages(i.e 10/11 becomes 10/12) on jth terms)
  List<int> j = [0, 5, 13, 21, 29];
  List<int> degreeofWind = [];

  Future<void> cityName(String cityName, BuildContext context) async {
    cityInfo = await gettingCityData(cityName, context);

    notifyListeners();
  }

  Future<void> gettingTheWeather({lat, lang, context, cityName}) async {
    weatherInfo = await gettingWeatherData(lat, lang);

    notifyListeners();
  }

  Future<void> pollutionIndex(lat, long) async {
    pollutionInfo = await pollutionService(lat, long);

    notifyListeners();
  }

  Future<void> fiveDayForcastData(lat, long) async {
    Map json = await gettingFiveDayData(lat, long);
    for (int i = 0; i < 5; i++) {
      FiveDayForcastData data = FiveDayForcastData(
        temp_min: json['list'][j[i]]['main']['temp_min'].toDouble(),

        date: json['list'][j[i]]['dt'],
        degreeofWind: json['list'][j[i]]['wind']['deg'],
        description: json['list'][j[i]]['weather'][0]['description'],
        icon: json['list'][j[i]]['weather'][0]['icon'],
        //change m/s to km/hr and taking 2 digits after decimal
        wind: double.parse(
            (json['list'][j[i]]['wind']['speed'].toDouble() * 3.6)
                .toStringAsFixed(2)),
      );
      fiveDayData.add(data);

      time.add(DateTime.fromMillisecondsSinceEpoch(data.date * 1000));
      day.add(DateFormat('EEE').format(time[i]));
      date.add(DateFormat('M/d').format(time[i]));
      minTemp.add(data.temp_min);
      iconString.add(data.icon);
      degreeofWind.add(data.degreeofWind);
      print(degreeofWind);
      print(minTemp);

      notifyListeners();
    }
  }

  List<int> windDirection(List<int> degree) {
    List<int> degreeValue = [];

    for (int i = 0; i < 5; i++) {
      if (degree[i] > 337.5) degreeValue.add(90);

      if (degree[i] > 292.5) degreeValue.add(135);
      if (degree[i] > 247.5) degreeValue.add(180);
      if (degree[i] > 202.5) degreeValue.add(225);
      if (degree[i] > 157.5) degreeValue.add(270);
      if (degree[i] > 122.5) degreeValue.add(315);
      if (degree[i] > 67.5) degreeValue.add(0);
      if (degree[i] > 22.5) degreeValue.add(45);
    }

    return degreeValue;
  }

  refreshFunction(BuildContext context, double lat, double long) async {
    await gettingTheWeather(
      lat: lat,
      lang: long,
    );
    await pollutionIndex(lat, long);
    await fiveDayForcastData(lat, long);
  }
}
