//this page is not yet used

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Pages/Home_page.dart';
import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/main.dart';
import '../model.dart/image_utils.dart';

class NotiProvider extends ChangeNotifier {
  String hh = 'hh';
  Future showNotification(BuildContext context) async {
    final bigPicturePath = await Utils.downloadFile(
        'http://openweathermap.org/img/wn/10d@4x.png', 'bigPicture');
    final largeIconPath = await Utils.downloadFile(
        'http://openweathermap.org/img/wn/10d.png', 'largeIcon');
    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      priority: Priority.max,
      //importance determines the behavior of shoing nofitifaion...if max then it comes as pop up
      //if not max then it will just come in notificaaton panel of app and we have to open the drawer to see it
      importance: Importance.max,
      styleInformation: styleInformation,

      enableVibration: true,
      playSound: true,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

//title and body of the notification
    await flutterLocalNotificationsPlugin.show(
        5, hh, 'body', notificationDetails);
    notifyListeners();
  }

  Future scheduledNotificationTest2(
    BuildContext context,
  ) async {
    var interval = RepeatInterval.everyMinute;
    final bigPicturePath = await Utils.downloadFile(
        'http://openweathermap.org/img/wn/${Provider.of<CityProvider>(context, listen: false).weatherInfo!.icon}@4x.png',
        'bigPicture');
    final largeIconPath = await Utils.downloadFile(
        'http://openweathermap.org/img/wn/${Provider.of<CityProvider>(context, listen: false).weatherInfo!.icon}.png',
        'largeIcon');
    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'chsawanneldaaaaaIddssd',

      'daaaaasa',
      priority: Priority.max,
      //importance determines the behavior of shoing nofitifaion...if max then it comes as pop up
      //if not max then it will just come in notificaaton panel of app and we have to open the drawer to see it
      importance: Importance.max,
      styleInformation: styleInformation,

      enableVibration: true,
      playSound: true,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));

    await flutterLocalNotificationsPlugin.periodicallyShow(
      10,
      'Today in ${Provider.of<CityProvider>(context, listen: false).cityInfo!.name}: ${Provider.of<CityProvider>(context, listen: false).weatherInfo!.description}',
      'Feels like:${Provider.of<CityProvider>(context, listen: false).weatherInfo!.feelsLike} \u00b0C.  See full forcast ',
      interval,
      notificationDetails,
      androidAllowWhileIdle: true,
      payload: 'i came from notifications',
    );
    notifyListeners();
  }
}
