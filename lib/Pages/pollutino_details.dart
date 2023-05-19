import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Provider/citiy_provider_two.dart';

import '../Provider/city_provider.dart';

class PollutionDetails extends StatelessWidget {
  bool isSecondCity;
  PollutionDetails({
    Key? key,
    required this.isSecondCity,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    String aab = !isSecondCity
        ? Provider.of<CityProvider>(context, listen: false)
            .pollutionInfo!
            .airQuality
            .toString()
        : Provider.of<CityProvider2>(context, listen: false)
            .pollutionInfo!
            .airQuality
            .toString();

    Map<String, dynamic> choosing = {
      '1.0': ['Good', 'The air is very very clean', Colors.green],
      '2.0': ['Fair', 'Could be cleaner but cannot complain', Colors.lightBlue],
      '3.0': [
        'Moderate',
        'Mask is not recommended but you know',
        Colors.yellow
      ],
      '4.0': ['Poor', 'Do not go out without a MASK', Colors.orange],
      '5.0': ['Very Poor', 'Do not go out. Stay inside and pray!  ', Colors.red]
    };

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.secondary,
      ),
      backgroundColor: colorScheme.secondary,
      body: Container(
        // color: Colors.amber,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Air Quality Index',
                style: TextStyle(
                  color: colorScheme.surface,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              !isSecondCity
                  ? Consumer<CityProvider>(
                      builder: ((context, value, child) => Text(
                            value.cityInfo!.name,
                            style: TextStyle(
                              color: colorScheme.surface,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    )
                  : Consumer<CityProvider2>(
                      builder: ((context, value, child) => Text(
                            value.cityInfo!.name,
                            style: TextStyle(
                              color: colorScheme.surface,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    ),
              SizedBox(
                height: 50,
              ),
              !isSecondCity
                  ? Consumer<CityProvider>(
                      builder: ((context, value, child) => Row(
                            children: [
                              Text(
                                value.pollutionInfo!.airQuality.toString(),
                                style: TextStyle(
                                  color: choosing[aab][2],
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  choosing[aab][0],
                                  style: TextStyle(
                                    color: choosing[aab][2],
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                  : Consumer<CityProvider2>(
                      builder: ((context, value, child) => Row(
                            children: [
                              Text(
                                value.pollutionInfo!.airQuality.toString(),
                                style: TextStyle(
                                  color: choosing[aab][2],
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  choosing[aab][0],
                                  style: TextStyle(
                                    color: choosing[aab][2],
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
              Text(
                choosing[aab][1],
                style: TextStyle(
                  color: colorScheme.surface,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 26,
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 90,
                width: size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: !isSecondCity
                        ? Provider.of<CityProvider>(context, listen: false)
                            .pollutionInfo!
                            .pollutants
                            .length
                        : Provider.of<CityProvider2>(context, listen: false)
                            .pollutionInfo!
                            .pollutants
                            .length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(children: [
                            !isSecondCity
                                ? Consumer<CityProvider>(
                                    builder: ((context, value, child) => Text(
                                          '${value.pollutionInfo!.pollutants[index].toString()}',
                                          style: TextStyle(
                                            color: choosing[aab][2],
                                            fontSize: 23,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )))
                                : Consumer<CityProvider2>(
                                    builder: ((context, value, child) => Text(
                                          '${value.pollutionInfo!.pollutants[index].toString()}',
                                          style: TextStyle(
                                            color: choosing[aab][2],
                                            fontSize: 23,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ))),
                            SizedBox(
                              height: 5,
                            ),
                            !isSecondCity
                                ? Consumer<CityProvider>(
                                    builder: ((context, value, child) => Text(
                                          value.pollutionInfo!
                                              .pollutantsName[index]
                                              .toString(),
                                          style: TextStyle(
                                            color: colorScheme.surface
                                                .withOpacity(0.8),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )))
                                : Consumer<CityProvider2>(
                                    builder: ((context, value, child) => Text(
                                          value.pollutionInfo!
                                              .pollutantsName[index]
                                              .toString(),
                                          style: TextStyle(
                                            color: colorScheme.surface
                                                .withOpacity(0.8),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ))),
                          ]),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'micrograms of pollutants per cubic meter of air',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                height: 66,
              ),
              Center(
                  child: Text(
                'powered by OpenWeatherApi',
                style: TextStyle(
                  color: Color.fromARGB(57, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
