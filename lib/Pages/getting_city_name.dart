import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weatherweather/Pages/Home_page.dart';
import 'package:weatherweather/Pages/snackbar.dart';
import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/Provider/notification_provider.dart';
import 'package:weatherweather/main.dart';
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
  //whenever GEtCityName widget is inserrted into the widget tree, the first function to run will be initState
  //initState will run only once for each State
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 2,
            colors: [Colors.green, Colors.orange, Colors.yellow],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Weather App',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              'Enter city name to continue',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 80,
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: usernameController,
                      validator: (user) =>
                          user!.isEmpty ? 'City name cannot be null' : null,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 4)),
                        focusColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.white, width: 4)),
                        hintText: 'kathmandu',
                        labelText: 'city',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(121, 255, 255, 255)),
                      ),
                    ),
                  ),
                  TextButton(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 80, 146),
                            fontWeight: FontWeight.bold),
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
                              Provider.of<CityProvider>(context, listen: false)
                                  .isClicked = true;
                              await Provider.of<CityProvider>(context,
                                      listen: false)
                                  .cityName(usernameController.text, context);
                              double lat = Provider.of<CityProvider>(context,
                                      listen: false)
                                  .cityInfo!
                                  .lat;
                              double long = Provider.of<CityProvider>(context,
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
                                      cityName:
                                          usernameController.text.toString());

                              await Provider.of<CityProvider>(context,
                                      listen: false)
                                  .pollutionIndex(lat, long);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
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
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
