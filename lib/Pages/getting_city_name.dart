import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weatherweather/Pages/Home_page.dart';
import 'package:weatherweather/Pages/single_city_details.dart';
import 'package:weatherweather/Pages/snackbar.dart';
import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/Provider/notification_provider.dart';
import 'package:weatherweather/main.dart';
import 'package:weatherweather/theme/constants.dart';
import 'package:weatherweather/services/current_location.dart';

class GetCityName extends StatefulWidget {
  const GetCityName({super.key});

  @override
  State<GetCityName> createState() => _GetCityNameState();
}

class _GetCityNameState extends State<GetCityName> {
  int buttonCount = 0;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                'assets/rain.svg',
                width: 120,
                height: 240,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Enter a city name',
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
                      controller: usernameController,
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
                            //checking internet conncetion when the button is pressed
                            try {
                              final result =
                                  await InternetAddress.lookup('example.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                print('connceted');
                                buttonCount++;
                                FocusManager.instance.primaryFocus?.unfocus();

                                final FormState? form = formKey.currentState;
                                if (form!.validate() == true) {
                                  Provider.of<CityProvider>(context,
                                          listen: false)
                                      .isClicked = true;
                                  await Provider.of<CityProvider>(context,
                                          listen: false)
                                      .cityName(
                                          usernameController.text, context);
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
                                  if (buttonCount > 1) {
                                    buttonCount = 1;
                                  }
                                  if (buttonCount == 1) {
                                    buttonCount = 0;
                                    showSnackBar(context,
                                        'Weather information for ${usernameController.text.toUpperCase()} is loading. Please wait.');
                                  }

                                  await Provider.of<CityProvider>(context,
                                          listen: false)
                                      .gettingTheWeather(
                                          lat: lat,
                                          lang: long,
                                          context: context,
                                          cityName: usernameController.text
                                              .toString());

                                  await Provider.of<CityProvider>(context,
                                          listen: false)
                                      .pollutionIndex(lat, long);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CityOneDetails(),
                                    ),
                                  );
                                  //condn when user presses multiple times when the city name form is null
                                  //i.e user presses contunue button many times without providing any city anme
                                }
                              }
                              //just catch(_) also works the same
                            } on SocketException catch (_) {
                              showSnackBar(context,
                                  'Check the internet connection and try again');
                            }
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
