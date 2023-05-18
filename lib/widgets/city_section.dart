// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Provider/citiy_provider_two.dart';

import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/theme/constants.dart';

class CitySection extends StatelessWidget {
  bool isSecondCity;
  CitySection({
    Key? key,
    required this.isSecondCity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    String conCode = !isSecondCity
        ? Provider.of<CityProvider>(context, listen: false)
            .weatherInfo!
            .countryCode
        : Provider.of<CityProvider2>(context, listen: false)
            .weatherInfo!
            .countryCode;
    CountryDetails details =
        CountryCodes.detailsForLocale(Locale('en', conCode));
    return SizedBox(
      width: 226,
      height: 61,
      child: Column(
        children: [
          !isSecondCity
              ? Consumer<CityProvider>(
                  builder: ((context, value, child) => Text(
                        ' ${value.cityInfo!.name.toUpperCase()}  ',
                        style: TextStyle(
                            color: colorScheme.surface.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      )),
                )
              : Consumer<CityProvider2>(
                  builder: ((context, value, child) => Text(
                        ' ${value.cityInfo!.name.toUpperCase()}  ',
                        style: TextStyle(
                            color: colorScheme.surface.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      )),
                ),
          const SizedBox(height: 4),
          !isSecondCity
              ? Consumer<CityProvider>(
                  builder: ((context, value, child) => Text(
                        ' ${details.localizedName.toString()}, ${DateFormat('EEE MMM d, hh:mm aaa').format(value.weatherInfo!.time)}',
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                )
              : Consumer<CityProvider2>(
                  builder: ((context, value, child) => Text(
                        ' ${details.localizedName.toString()}, ${DateFormat('EEE MMM d, hh:mm aaa').format(value.weatherInfo!.time)}',
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
        ],
      ),
    );
  }
}
