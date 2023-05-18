// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherweather/Pages/Five_Day_Forcast.dart';
import 'package:weatherweather/Provider/citiy_provider_two.dart';
import 'package:weatherweather/Provider/city_provider.dart';

class FiveDaySection extends StatefulWidget {
  bool isSecondCity;
  FiveDaySection({
    Key? key,
    required this.isSecondCity,
  }) : super(key: key);

  @override
  State<FiveDaySection> createState() => _FiveDaySectionState();
}

class _FiveDaySectionState extends State<FiveDaySection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: SizedBox(
            height: 48,
            width: size.width,
            child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(
                              width: 3.0,
                              color: Color.fromARGB(119, 255, 255, 255))))),
              onPressed: () async {
                !widget.isSecondCity
                    ? Provider.of<CityProvider>(context, listen: false)
                        .degreeofWind = []
                    : Provider.of<CityProvider2>(context, listen: false)
                        .degreeofWind = [];

                !widget.isSecondCity
                    ? Provider.of<CityProvider>(context, listen: false)
                        .minTemp = []
                    : Provider.of<CityProvider2>(context, listen: false)
                        .minTemp = [];
                double lat = !widget.isSecondCity
                    ? Provider.of<CityProvider>(context, listen: false)
                        .cityInfo!
                        .lat
                    : Provider.of<CityProvider2>(context, listen: false)
                        .cityInfo!
                        .lat;
                double long = !widget.isSecondCity
                    ? Provider.of<CityProvider>(context, listen: false)
                        .cityInfo!
                        .lat
                    : Provider.of<CityProvider2>(context, listen: false)
                        .cityInfo!
                        .lat;

                !widget.isSecondCity
                    ? await Provider.of<CityProvider>(context, listen: false)
                        .fiveDayForcastData(lat, long)
                    : await Provider.of<CityProvider2>(context, listen: false)
                        .fiveDayForcastData(lat, long);
                !widget.isSecondCity
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FiveDayDetails(
                            isSecondCity: false,
                            lat: lat,
                            long: long,
                          ),
                        ))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FiveDayDetails(
                            lat: lat,
                            long: long,
                            isSecondCity: true,
                          ),
                        ));
              },
              child: const Text(
                '5-day forcast',
                style: TextStyle(
                  color: Color.fromARGB(119, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )));
  }
}
