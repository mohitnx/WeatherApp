import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherInfo {
  String icon;
  String countryCode;
  String description;
  double temp;
  double humidity;
  double windSpeed;
  double feelsLike;
  double cloudPercent;

  int sunrise;
  int sunset;
  DateTime time;

  String cSunrise() {
    var covertimeTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    return DateFormat(' hh:mm aaa').format(covertimeTime);
  }

  String cSunset() {
    var covertimeTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    return DateFormat(' hh:mm aaa').format(covertimeTime);
  }

  AssetImage settingBgPicture() {
    var bgPic;
    var c1 = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    var c2 = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);

    if (DateTime.now().isAfter(c1) && DateTime.now().isBefore(c2)) {
      bgPic = AssetImage('assets/day.jpg');
    } else {
      bgPic = AssetImage('assets/night.jpg');
    }
    return bgPic;
  }
  // WeatherInfo(this.icon, this.description, this.temp, this.humidity,
  //     this.windSpeed, this.feelsLike, this.cloudPercent);

  WeatherInfo.fromJson(Map<String, dynamic> json)
      : icon = json['weather'][0]['icon'],
        countryCode = json['sys']['country'],
        sunrise = json['sys']['sunrise'],
        sunset = json['sys']['sunset'],
        description = json['weather'][0]['description'],
        temp = json['main']['temp'].toDouble(),
        humidity = json['main']['humidity'].toDouble(),
        windSpeed = json['wind']['speed'].toDouble(),
        feelsLike = json['main']['feels_like'].toDouble(),
        time = DateTime.now().add(Duration(
            seconds:
                json['timezone'] - DateTime.now().timeZoneOffset.inSeconds)),
        cloudPercent = json['clouds']['all'].toDouble();
}

     //   DateFormat('EEE, MMM d, hh:mm aaa').format(covertimeTime); 