import 'package:flutter/cupertino.dart';
import 'package:weatherweather/Pages/snackbar.dart';

class CityInfo {
  String name;
  double lat;
  double long;

  CityInfo({required this.name, required this.lat, required this.long});
//without static keyword we get error in city_servie.dart saying ' Instance member 'fromJson' can't be accessed using static access.'
//turns out either we need to instantiate the class or declare method static before using
//as to access the static method we don't need to create a class instance so we make fromJson static
//simply static means a member is availibale on the class itself instead of on instances of the class
//static means the class has access to it and not the class instances, meaning theere is only one copy of that variable / method if it is staic
//to know more: https://stackoverflow.com/questions/66594141/why-we-should-use-static-keyword-in-dart-in-place-of-abstract

//why static was needed in this case?
//in city service i accessed fromJson, i could do this direclty wihtoout creating an instance of the class
//cityInfo first as fromJson is a staic method
  static CityInfo? fromJson(List<dynamic> json, BuildContext context) {
    if (json.isEmpty) {
      showSnackBar(context, 'Enter a valid city name');
    }
    return CityInfo(
      name: json[0]['name'],
      lat: json[0]['lat'].toDouble(),
      long: json[0]['lon'].toDouble(),
    );
  }
}
