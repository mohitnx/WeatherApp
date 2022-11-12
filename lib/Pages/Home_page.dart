import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Pages/Five_Day_Forcast.dart';

import 'package:weatherweather/Pages/getting_city_name.dart';
import 'package:weatherweather/Pages/pollutino_details.dart';
import 'package:weatherweather/Pages/snackbar.dart';
import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/model.dart/constants.dart';

import '../services/current_location.dart';
import '../services/five_day_service.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Constants myColor = Constants();

  @override
  Widget build(BuildContext context) {
    double lat =
        Provider.of<CityProvider>(context, listen: false).cityInfo!.lat;
    double long =
        Provider.of<CityProvider>(context, listen: false).cityInfo!.long;

    String conCode = Provider.of<CityProvider>(context, listen: false)
        .weatherInfo!
        .countryCode;
    CountryDetails details =
        CountryCodes.detailsForLocale(Locale('en', conCode));

    String img_icon =
        Provider.of<CityProvider>(context, listen: false).weatherInfo!.icon;
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Provider.of<CityProvider>(context, listen: false)
                  .weatherInfo!
                  .settingBgPicture(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                TextButton(
                  child: Text(
                    'Change  City',
                    style: TextStyle(color: myColor.secondaryColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetCityName(),
                      ),
                    );
                  },
                ),
                TextButton(
                  child: Text(
                    'Refresh',
                    style: TextStyle(color: myColor.secondaryColor),
                  ),
                  onPressed: () async {
                    try {
                      final result =
                          await InternetAddress.lookup('example.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        await Provider.of<CityProvider>(context, listen: false)
                            .refreshFunction(context, lat, long);
                      }
                    } on SocketException catch (_) {
                      showSnackBar(context,
                          'Check the internet connection and try again');
                    }
                  },
                ),
              ],
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Consumer<CityProvider>(
                          builder: ((context, value, child) => Text(
                                value.cityInfo!.name.toString(),
                                style: TextStyle(
                                    color:
                                        myColor.secondaryColor.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                              )),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Consumer<CityProvider>(
                            builder: ((context, value, child) => Text(
                                  details.localizedName.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 100, 86, 86)
                                          .withOpacity(.4)),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<CityProvider>(
                      builder: ((context, value, child) => Text(
                            '${DateFormat('EEE, MMM d, hh:mm aaa').format(value.weatherInfo!.time)}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(163, 87, 89, 90)),
                          ))),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: size.width,
                    height: 300,
                    decoration: BoxDecoration(
                        color: myColor.primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: myColor.primaryColor.withOpacity(0.3),
                              offset: Offset(0, 25),
                              blurRadius: 10,
                              spreadRadius: -12),
                        ]),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 24,
                          bottom: 120,
                          child: Image.network(
                            'http://openweathermap.org/img/wn/${img_icon}@4x.png',
                            scale: 0.66,
                          ),
                        ),
                        Align(
                          heightFactor: 6,
                          alignment: Alignment.bottomCenter,
                          child: Consumer<CityProvider>(
                            builder: ((context, value, child) => TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  width: 3.0,
                                                  color: Color.fromARGB(
                                                      119, 255, 255, 255))))),
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PollutionDetails(),
                                        ));
                                  },
                                  child: Text(
                                    'AQI: ${value.pollutionInfo!.airQuality.toString()}',
                                    style: TextStyle(
                                      color: Color.fromARGB(119, 255, 255, 255),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        Positioned(
                          top: 130,
                          left: size.width / 4,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Consumer<CityProvider>(
                                  builder: ((context, value, child) => Text(
                                        value.weatherInfo!.temp.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 63,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ),
                              ),
                              Text(
                                '\u00b0 C',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          heightFactor: 13,
                          alignment: Alignment.bottomCenter,
                          child: Consumer<CityProvider>(
                            builder: ((context, value, child) => Text(
                                  value.weatherInfo!.description.toString(),
                                  style: TextStyle(
                                    color: Color.fromARGB(137, 255, 255, 255),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 160,
                          width: 110,
                          decoration: BoxDecoration(
                              color: myColor.primaryColor.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/car.png'),
                              Text('Feels Like'),
                              Consumer<CityProvider>(
                                builder: ((context, value, child) => Text(
                                      value.weatherInfo!.feelsLike.toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(168, 255, 255, 255),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              Text('\u00b0 C'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 160,
                          width: 110,
                          decoration: BoxDecoration(
                              color: myColor.primaryColor.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/car.png'),
                              Text('Wind speed'),
                              Consumer<CityProvider>(
                                builder: ((context, value, child) => Text(
                                      value.weatherInfo!.windSpeed.toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(168, 255, 255, 255),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              Text('m/sec'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 160,
                          width: 110,
                          decoration: BoxDecoration(
                              color: myColor.primaryColor.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/car.png'),
                              Text('Cloud'),
                              Consumer<CityProvider>(
                                builder: ((context, value, child) => Text(
                                      value.weatherInfo!.cloudPercent
                                          .toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(168, 255, 255, 255),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              Text('%'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 160,
                          width: 110,
                          decoration: BoxDecoration(
                              color: myColor.primaryColor.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/car.png'),
                              Text('Humidity'),
                              Consumer<CityProvider>(
                                builder: ((context, value, child) => Text(
                                      value.weatherInfo!.humidity.toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(168, 255, 255, 255),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              Text('%'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/day.jpg',
                              ),
                            ),
                          ),
                          Text(
                            'Sunrise',
                            style: TextStyle(
                              fontSize: 16,
                              color: myColor.secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Consumer<CityProvider>(
                              builder: ((context, value, child) => Text(
                                    value.weatherInfo!.cSunrise(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: myColor.secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ))),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/night.jpg',
                              ),
                            ),
                          ),
                          Text(
                            'Sunset',
                            style: TextStyle(
                              color: myColor.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Consumer<CityProvider>(
                              builder: ((context, value, child) => Text(
                                    value.weatherInfo!.cSunset(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: myColor.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ))),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                      child: Container(
                    height: 40,
                    width: size.width,
                    child: TextButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          width: 3.0,
                                          color: Color.fromARGB(
                                              119, 255, 255, 255))))),
                      onPressed: () async {
                        Provider.of<CityProvider>(context, listen: false)
                            .degreeofWind = [];

                        Provider.of<CityProvider>(context, listen: false)
                            .minTemp = [];
                        double lat =
                            Provider.of<CityProvider>(context, listen: false)
                                .cityInfo!
                                .lat;
                        double long =
                            Provider.of<CityProvider>(context, listen: false)
                                .cityInfo!
                                .lat;

                        await Provider.of<CityProvider>(context, listen: false)
                            .fiveDayForcastData(lat, long);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FiveDayDetails(
                                lat: lat,
                                long: long,
                              ),
                            ));
                      },
                      child: Text(
                        '5-day forcast',
                        style: TextStyle(
                          color: Color.fromARGB(119, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
