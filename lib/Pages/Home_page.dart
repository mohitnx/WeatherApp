import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherweather/Pages/single_city_details.dart';
import 'package:weatherweather/Pages/snackbar.dart';
import 'package:weatherweather/Provider/city_provider.dart';

import '../Provider/notification_provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startNotifications();
  }

  void startNotifications() async {
    await Provider.of<NotiProvider>(context, listen: false)
        .scheduledNotificationTest2(
      context,
    );

    print('notifiaaaaaaaaaa');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      physics: BouncingScrollPhysics(),
      children: const [
        CityOneDetails(),
        CityTwoDetails(),
      ],
    ));
  }
}
