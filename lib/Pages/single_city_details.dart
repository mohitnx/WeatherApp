import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Pages/getting_city_name.dart';
import 'package:weatherweather/Pages/snackbar.dart';
import 'package:weatherweather/Provider/citiy_provider_two.dart';

import 'package:weatherweather/widgets/body_seciton.dart';
import 'package:weatherweather/widgets/city_section.dart';
import 'package:weatherweather/widgets/drawer_section.dart';
import 'package:weatherweather/widgets/five_day_section.dart';
import 'package:weatherweather/widgets/footer_section.dart';

import '../Provider/city_provider.dart';

class CityOneDetails extends StatefulWidget {
  const CityOneDetails({super.key});

  @override
  State<CityOneDetails> createState() => _CityOneDetailsState();
}

class _CityOneDetailsState extends State<CityOneDetails> {
  bool menuOpened = false;
  double tranx = 0, trany = 0, scale = 1.0;
  double radiusBorder = 0;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    double lat =
        Provider.of<CityProvider>(context, listen: false).cityInfo!.lat;
    double long =
        Provider.of<CityProvider>(context, listen: false).cityInfo!.long;

    handleRefresh() async {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await Provider.of<CityProvider>(context, listen: false)
              .refreshFunction(context, lat, long);
        }
      } on SocketException catch (_) {
        showSnackBar(context, 'Check the internet connection and try again');
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          const DrawerSection(),
          AnimatedContainer(
            transform: Matrix4.translationValues(tranx, trany, 0)..scale(scale),
            duration: const Duration(milliseconds: 150),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusBorder),
              image: DecorationImage(
                  image: Provider.of<CityProvider>(context, listen: false)
                      .weatherInfo!
                      .settingBgPicture(),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      colorScheme.secondary.withOpacity(0.6),
                      BlendMode.srcOver)),
            ),
            child: LiquidPullToRefresh(
              showChildOpacityTransition: false,
              springAnimationDurationInMilliseconds: 200,
              color: Colors.transparent,
              backgroundColor: colorScheme.onSurface,
              animSpeedFactor: 1.0,
              height: 90,
              onRefresh: handleRefresh,
              child: ListView(
                children: [
                  //SizedBox(height: 64),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !menuOpened
                          ? IconButton(
                              onPressed: () {
                                scale = 0.8;
                                tranx = 180;
                                trany = 150;
                                radiusBorder = 38;
                                setState(() {
                                  menuOpened = true;
                                });
                              },
                              icon: Icon(
                                Icons.menu,
                                color: colorScheme.onSurface,
                              ))
                          : IconButton(
                              onPressed: () {
                                scale = 1.0;
                                tranx = 00;
                                trany = 00;
                                radiusBorder = 0;
                                setState(() {
                                  menuOpened = false;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: colorScheme.onSurface,
                              )),
                      Text(
                        DateFormat(' hh:mm aaa').format(DateTime.now()),
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GetCityName(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),
                  CitySection(isSecondCity: false),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 4,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 8,
                        height: 4,
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  BodySection(isSecondCity: false),
                  const SizedBox(height: 20),
                  FooterSection(isSecondCity: false),
                  const SizedBox(height: 25),
                  FiveDaySection(isSecondCity: false),
                  const SizedBox(height: 45),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CityTwoDetails extends StatefulWidget {
  const CityTwoDetails({super.key});

  @override
  State<CityTwoDetails> createState() => _CityTwoDetailsState();
}

class _CityTwoDetailsState extends State<CityTwoDetails> {
  bool menuOpened = false;
  double tranx = 0, trany = 0, scale = 1.0;
  double radiusBorder = 0;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    double lat =
        Provider.of<CityProvider2>(context, listen: false).cityInfo!.lat;
    double long =
        Provider.of<CityProvider2>(context, listen: false).cityInfo!.long;

    handleRefresh() async {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await Provider.of<CityProvider2>(context, listen: false)
              .refreshFunction(context, lat, long);
        }
      } on SocketException catch (_) {
        showSnackBar(context, 'Check the internet connection and try again');
      }
    }

    return Stack(
      children: [
        const DrawerSection(),
        AnimatedContainer(
          transform: Matrix4.translationValues(tranx, trany, 0)..scale(scale),
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusBorder),
            image: DecorationImage(
                image: Provider.of<CityProvider2>(context, listen: false)
                    .weatherInfo!
                    .settingBgPicture(),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    colorScheme.secondary.withOpacity(0.6), BlendMode.srcOver)),
          ),
          child: LiquidPullToRefresh(
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 200,
            color: Colors.transparent,
            backgroundColor: colorScheme.onSurface,
            animSpeedFactor: 1.0,
            height: 90,
            onRefresh: handleRefresh,
            child: ListView(
              children: [
                //SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !menuOpened
                        ? IconButton(
                            onPressed: () {
                              scale = 0.8;
                              tranx = 180;
                              trany = 150;
                              radiusBorder = 38;
                              setState(() {
                                menuOpened = true;
                              });
                            },
                            icon: Icon(
                              Icons.menu,
                              color: colorScheme.onSurface,
                            ))
                        : IconButton(
                            onPressed: () {
                              scale = 1.0;
                              tranx = 00;
                              trany = 00;
                              radiusBorder = 0;
                              setState(() {
                                menuOpened = false;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: colorScheme.onSurface,
                            )),
                    Text(
                      DateFormat(' hh:mm aaa').format(DateTime.now()),
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetCityName(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.search,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),
                CitySection(isSecondCity: true),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: 20,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                BodySection(isSecondCity: true),
                const SizedBox(height: 20),
                FooterSection(isSecondCity: true),
                const SizedBox(height: 25),
                FiveDaySection(isSecondCity: true),
                const SizedBox(height: 45),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
