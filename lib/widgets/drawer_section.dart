import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Pages/Home_page.dart';
import 'package:weatherweather/Pages/default_cities.dart';
import 'package:weatherweather/Pages/snackbar.dart';
import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/Provider/notification_provider.dart';
import 'package:weatherweather/main.dart';
import 'package:weatherweather/theme/constants.dart';
import 'package:weatherweather/theme/theme_manager.dart';

class DrawerSection extends StatefulWidget {
  const DrawerSection({super.key});

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Icon(
              Icons.radar_outlined,
              size: 90,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Weather App',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Container(
            width: 160,
            child: Divider(
              height: 20,
              thickness: 1,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Cities',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 28,
          ),
          ValueListenableBuilder(
            valueListenable: Hive.box<List>('cities').listenable(),
            builder: (context, box, _) {
              List myStrings = box.get('myKey') ?? [];
              return ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: myStrings.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () async {
                        try {
                          final result =
                              await InternetAddress.lookup('example.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            FocusManager.instance.primaryFocus?.unfocus();

                            Provider.of<CityProvider>(context, listen: false)
                                .isClicked = true;
                            await Provider.of<CityProvider>(context,
                                    listen: false)
                                .cityName(myStrings[index], context);
                            double lat = Provider.of<CityProvider>(context,
                                    listen: false)
                                .cityInfo!
                                .lat;
                            double long = Provider.of<CityProvider>(context,
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
                                    cityName: myStrings[index]);

                            await Provider.of<CityProvider>(context,
                                    listen: false)
                                .pollutionIndex(lat, long);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          }
                        } on SocketException catch (_) {
                          showSnackBar(context,
                              'Check the internet connection and try again');
                        }
                      },
                      child: Text(myStrings[index]));
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 15,
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DefaultCities(),
                ),
              );
            },
            child: Text(
              'Edit list',
              style: TextStyle(color: colorScheme.surface.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 5.2,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text('dark mode'),
              Switch(
                  value: Provider.of<ThemeManager>(context).themeMode ==
                      ThemeMode.dark,
                  onChanged: (_) {
                    Provider.of<ThemeManager>(context, listen: false)
                        .toggleTheme();
                  })
            ],
          ),
        ],
      ),
    );
  }
}
