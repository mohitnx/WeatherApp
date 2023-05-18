// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Provider/citiy_provider_two.dart';

import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/theme/constants.dart';

class FooterSection extends StatefulWidget {
  bool isSecondCity;
  FooterSection({
    Key? key,
    required this.isSecondCity,
  }) : super(key: key);

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: !widget.isSecondCity
            ? Consumer<CityProvider>(
                builder: ((context, value, child) => Row(
                      children: [
                        footerDetail(
                            Icons.thermostat,
                            'Feels Like',
                            value.weatherInfo!.feelsLike.toString(),
                            '\u00b0 C',
                            colorScheme),
                        const SizedBox(width: 36),
                        footerDetail(
                            Icons.wind_power,
                            'Wind Speed',
                            value.weatherInfo!.windSpeed.toString(),
                            'm/sec',
                            colorScheme),
                        const SizedBox(width: 36),
                        footerDetail(
                            Icons.cloud_sharp,
                            'Clouds',
                            value.weatherInfo!.cloudPercent.toString(),
                            '%',
                            colorScheme),
                        const SizedBox(width: 36),
                        footerDetail(
                            Icons.air,
                            'Humidity',
                            value.weatherInfo!.humidity.toString(),
                            '%',
                            colorScheme),
                        const SizedBox(width: 36),
                      ],
                    )),
              )
            : Consumer<CityProvider2>(
                builder: ((context, value, child) => Row(
                      children: [
                        footerDetail(
                            Icons.thermostat,
                            'Feels Like',
                            value.weatherInfo!.feelsLike.toString(),
                            '\u00b0 C',
                            colorScheme),
                        const SizedBox(width: 36),
                        footerDetail(
                            Icons.wind_power,
                            'Wind Speed',
                            value.weatherInfo!.windSpeed.toString(),
                            'm/sec',
                            colorScheme),
                        const SizedBox(width: 36),
                        footerDetail(
                            Icons.cloud_sharp,
                            'Clouds',
                            value.weatherInfo!.cloudPercent.toString(),
                            '%',
                            colorScheme),
                        const SizedBox(width: 36),
                        footerDetail(
                            Icons.air,
                            'Humidity',
                            value.weatherInfo!.humidity.toString(),
                            '%',
                            colorScheme),
                        const SizedBox(width: 36),
                      ],
                    )),
              ));
  }
}

Widget footerDetail(IconData icon, String title, var valuee, String unit,
    ColorScheme colorScheme) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(
          10,
        ),
        decoration: BoxDecoration(
          color: colorScheme.secondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(
          icon,
          color: colorScheme.onSurface,
          size: 40,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(168, 255, 255, 255),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        '$valuee $unit',
        style: TextStyle(
          color: colorScheme.surface,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
