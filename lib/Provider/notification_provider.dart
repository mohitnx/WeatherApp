//this page is not yet used

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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

//   Future scheduledNotificationTest2(BuildContext context, String description,
//       double temp, String iconName, int timeZone) async {
//     DateTime covertimeTime = DateTime.now().add(
//         Duration(seconds: timeZone - DateTime.now().timeZoneOffset.inSeconds));
//     String formattedDate =
//         DateFormat('EEE, MMM d, hh:mm aaa').format(covertimeTime);
//     var interval = RepeatInterval.everyMinute;
//     final bigPicturePath = await Utils.downloadFile(
//         'http://openweathermap.org/img/wn/10d@4x.png', 'bigPicture');
//     final largeIconPath = await Utils.downloadFile(
//         'http://openweathermap.org/img/wn/$iconName.png', 'largeIcon');
//     final styleInformation = BigPictureStyleInformation(
//       FilePathAndroidBitmap(bigPicturePath),
//       largeIcon: FilePathAndroidBitmap(largeIconPath),
//     );
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'channelIddd',

//       'channelNameee',
//       priority: Priority.max,
//       //importance determines the behavior of shoing nofitifaion...if max then it comes as pop up
//       //if not max then it will just come in notificaaton panel of app and we have to open the drawer to see it
//       importance: Importance.max,
//       styleInformation: styleInformation,

//       enableVibration: true,
//       playSound: true,
//     );
//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));
// //title and body of the notification
//     // ignore: deprecated_member_use
//     //use zonedSechdule instead using  timeZone package
//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       2,
//       description,
//       temp.toString() + '  ' + formattedDate,
//       interval,
//       notificationDetails,
//       androidAllowWhileIdle: true,
//     );
//     notifyListeners();
//   }
}
