// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherweather/Pages/pollutino_details.dart';
import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/theme/constants.dart';

import '../Provider/citiy_provider_two.dart';

class BodySection extends StatefulWidget {
  bool isSecondCity;
  BodySection({
    Key? key,
    required this.isSecondCity,
  }) : super(key: key);

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    String imgIcon = !widget.isSecondCity
        ? Provider.of<CityProvider>(context, listen: false).weatherInfo!.icon
        : Provider.of<CityProvider2>(context, listen: false).weatherInfo!.icon;
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 310,
      decoration: BoxDecoration(
        color: colorScheme.secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 24,
            bottom: 120,
            child: Image.network(
              'http://openweathermap.org/img/wn/$imgIcon@4x.png',
              scale: 0.66,
              color: colorScheme.onSurface,
            ),
          ),
          Align(
            heightFactor: 6,
            alignment: Alignment.bottomCenter,
            child: !widget.isSecondCity
                ? Consumer<CityProvider>(
                    builder: ((context, value, child) => TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          width: 3.0,
                                          color: Color.fromARGB(
                                              119, 255, 255, 255))))),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PollutionDetails(
                                    isSecondCity: false,
                                  ),
                                ));
                          },
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'AQI: ',
                                  style: TextStyle(
                                    color: Color.fromARGB(119, 255, 255, 255),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  value.pollutionInfo!.airQuality.toString(),
                                  style: TextStyle(
                                    color: colorScheme.surface,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  )
                : Consumer<CityProvider2>(
                    builder: ((context, value, child) => TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          width: 3.0,
                                          color: Color.fromARGB(
                                              119, 255, 255, 255))))),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PollutionDetails(
                                    isSecondCity: true,
                                  ),
                                ));
                          },
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'AQI: ',
                                  style: TextStyle(
                                    color: Color.fromARGB(119, 255, 255, 255),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  value.pollutionInfo!.airQuality.toString(),
                                  style: TextStyle(
                                    color: colorScheme.surface,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                  child: !widget.isSecondCity
                      ? Consumer<CityProvider>(
                          builder: ((context, value, child) => Text(
                                value.weatherInfo!.temp.toString(),
                                style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontSize: 63,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )
                      : Consumer<CityProvider2>(
                          builder: ((context, value, child) => Text(
                                value.weatherInfo!.temp.toString(),
                                style: TextStyle(
                                  color: colorScheme.onSurface,
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
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Align(
            heightFactor: 13,
            alignment: Alignment.bottomCenter,
            child: !widget.isSecondCity
                ? Consumer<CityProvider>(
                    builder: ((context, value, child) => Text(
                          value.weatherInfo!.description.toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(137, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  )
                : Consumer<CityProvider2>(
                    builder: ((context, value, child) => Text(
                          value.weatherInfo!.description.toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(137, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ),
          ),
        ],
      ),
    );
  }
}
