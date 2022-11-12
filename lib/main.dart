// import 'dart:convert';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Pages/Home_page.dart';

import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/Provider/notification_provider.dart';
import 'package:weatherweather/model.dart/constants.dart';

import 'Pages/getting_city_name.dart';
import 'services/current_location.dart';

// Constants myConstants = Constants();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  bool? initialized = await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  print(initialized);

  await CountryCodes.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CityProvider>(
            create: (context) => CityProvider()),
        ChangeNotifierProvider<NotiProvider>(
          create: (context) => NotiProvider(),
        ),
        //CurrentLocation
        ChangeNotifierProvider<CurrentLocation>(
          create: (context) => CurrentLocation(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GetCityName(),
      ),
    );
  }
}



// //basic jist
// //http.get returns a Response string
// //we coveert that response to a json by built in jsonDecode func (jsonDecode takes a string, i.e result of http.get which is response.body)
// //jsonDecode returns a json object which is a map... we can directly use the json object but it may have more things than we need
//and we don't the type of data we are working with until runtime..and features of statically typed lang like complite time excepton, type safety etc can't be used
//and code becomes more error prone
// // we convert that json object to a User object with frmJson named constructor..where name is assigned to json[][]and email to json[][]
// //belwo future returns such a User object.
// //now to use the data/display the data...use future builder that takes the futuer gettngWeatherDAta
// //since the Future returns User we can user User.name and User.email to display the data
// //finsihh simplee



//testing 
// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   Future<User> gettingWeatherData() async {
//     var url = Uri.parse(
//         'https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=82c7b99e2a8215351147f607592a3e63');
//     var response = await http.get(url);
//     if (response.statusCode == 200)
//       return User.fromJson(jsonDecode(response.body));
//     else
//       throw Exception('failed');
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: Container(
//       width: size.width,
//       height: size.height,
//       color: Colors.red,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FutureBuilder(
//               future: gettingWeatherData(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData)
//                   return Column(
//                     children: [
//                       Text(snapshot.data!.name.toString()),
//                       Text(snapshot.data!.email.toString()),
//                     ],
//                   );
//                 else if (snapshot.hasError) {
//                   return Text('error');
//                 } else
//                   return CircularProgressIndicator();
//               })
//         ],
//       ),
//     ));
//   }
// }

// class User {
//   final String name;
//   final double email;

//   User({required this.name, required this.email});

//   User.fromJson(Map<String, dynamic> json)
//       : name = json['weather'][0]['main'],
//         email = json['main']['temp'].toDouble();
// }
