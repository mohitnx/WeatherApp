import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Pages/Home_page.dart';
import 'package:weatherweather/Pages/snackbar.dart';
import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/Provider/notification_provider.dart';
import 'package:weatherweather/theme/constants.dart';

import '../Provider/citiy_provider_two.dart';

class DefaultCities extends StatefulWidget {
  const DefaultCities({super.key});

  @override
  State<DefaultCities> createState() => _DefaultCitiesState();
}

class _DefaultCitiesState extends State<DefaultCities> {
  final box = Hive.box<List>('cities');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController city1controller = TextEditingController();
    TextEditingController city2controller = TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'assets/city.svg',
                width: 120,
                height: 240,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Enter names of two cities to get started',
                style: TextStyle(
                    fontSize: 28,
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(color: colorScheme.onSurface),
                      controller: city1controller,
                      validator: (user) =>
                          user!.isEmpty ? 'City name cannot be null' : null,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 4)),
                        focusColor: colorScheme.onSurface,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide: BorderSide(
                                color: colorScheme.onSurface, width: 4)),
                        hintText: 'kathmandu',
                        labelText: 'city',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(121, 255, 255, 255)),
                      ),
                    ),
                    SizedBox(
                      height: 20.5,
                    ),
                    TextFormField(
                      style: TextStyle(color: colorScheme.onSurface),
                      controller: city2controller,
                      validator: (user) =>
                          user!.isEmpty ? 'City name cannot be null' : null,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 4)),
                        focusColor: colorScheme.onSurface,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide: BorderSide(
                                color: colorScheme.onSurface, width: 4)),
                        hintText: 'Sydney',
                        labelText: 'city',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(121, 255, 255, 255)),
                      ),
                    ),
                    SizedBox(
                      height: 20.5,
                    ),
                    const SizedBox(
                      height: 20.5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      side: const BorderSide(
                                          width: 3.0,
                                          color: Color.fromARGB(
                                              119, 255, 255, 255))))),
                          child: Text(
                            'Get weather Details',
                            style: TextStyle(
                              fontSize: 16,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              final result =
                                  await InternetAddress.lookup('example.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                FocusManager.instance.primaryFocus?.unfocus();

                                final FormState? form = formKey.currentState;
                                if (form!.validate() == true) {
                                  List myList = box.get('myKey') ?? [];
                                  myList.clear();
                                  myList.add(city1controller.text.trim());
                                  myList.add(city2controller.text.trim());
                                  box.put('myKey', myList);
                                  Provider.of<CityProvider>(context,
                                          listen: false)
                                      .isClicked = true;
                                  Provider.of<CityProvider2>(context,
                                          listen: false)
                                      .isClicked = true;
                                  await Provider.of<CityProvider>(context,
                                          listen: false)
                                      .cityName(city1controller.text, context);
                                  await Provider.of<CityProvider2>(context,
                                          listen: false)
                                      .cityName(city2controller.text, context);
                                  double lat = Provider.of<CityProvider>(
                                          context,
                                          listen: false)
                                      .cityInfo!
                                      .lat;
                                  double long = Provider.of<CityProvider>(
                                          context,
                                          listen: false)
                                      .cityInfo!
                                      .long;

                                  double lat2 = Provider.of<CityProvider2>(
                                          context,
                                          listen: false)
                                      .cityInfo!
                                      .lat;
                                  double long2 = Provider.of<CityProvider2>(
                                          context,
                                          listen: false)
                                      .cityInfo!
                                      .long;

                                  showSnackBar(context,
                                      'Weather information is loading. Please wait.');

                                  await Provider.of<CityProvider>(context,
                                          listen: false)
                                      .gettingTheWeather(
                                          lat: lat,
                                          lang: long,
                                          context: context,
                                          cityName:
                                              city1controller.text.toString());
                                  await Provider.of<CityProvider2>(context,
                                          listen: false)
                                      .gettingTheWeather(
                                          lat: lat2,
                                          lang: long2,
                                          context: context,
                                          cityName:
                                              city2controller.text.toString());

                                  await Provider.of<CityProvider>(context,
                                          listen: false)
                                      .pollutionIndex(lat, long);

                                  // await Provider.of<NotiProvider>(context,
                                  //         listen: false)
                                  //     .scheduledNotificationTest2(
                                  //   context,
                                  // );

                                  await Provider.of<CityProvider2>(context,
                                          listen: false)
                                      .pollutionIndex(lat2, long2);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  );
                                }
                              }
                            } on SocketException catch (_) {
                              showSnackBar(context,
                                  'Check the internet connection and try again');
                            }
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
