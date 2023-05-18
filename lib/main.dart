// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'package:weatherweather/Pages/Home_page.dart';
import 'package:weatherweather/Pages/default_cities.dart';
import 'package:weatherweather/Provider/citiy_provider_two.dart';
import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/Provider/notification_provider.dart';
import 'package:weatherweather/theme/constants.dart';
import 'package:weatherweather/theme/theme_manager.dart';

import 'services/current_location.dart';

// Constants myConstants = Constants();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox<List>('cities');

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
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeManager>(
            create: (context) => ThemeManager()),
        ChangeNotifierProvider<CityProvider>(
            create: (context) => CityProvider()),

        ChangeNotifierProvider<CityProvider2>(
            create: (context) => CityProvider2()),
        ChangeNotifierProvider<NotiProvider>(
          create: (context) => NotiProvider(),
        ),
        //CurrentLocation
        ChangeNotifierProvider<CurrentLocation>(
          create: (context) => CurrentLocation(),
        ),
      ],
      child: MyApp(
        box: box,
      )));
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  Box box;
  MyApp({
    Key? key,
    required this.box,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    List cities = widget.box.get('myKey');

    return Consumer<ThemeManager>(
      builder: (context, themeManager, _) {
        final Color primaryColor = Color.fromARGB(255, 63, 169, 198);
        final Color secondaryColor = Color.fromARGB(255, 73, 16, 195);
        final Color cityColor = Color(0xFFFFD400);
        final Color whiteColor = Colors.white;
        final ThemeData lightTheme = ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: primaryColor,
            secondary: secondaryColor,
            surface: cityColor,
            onSurface: whiteColor,
          ),
        );
        final ThemeData darkTheme = ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Color.fromARGB(255, 50, 88, 99),
            secondary: Color.fromARGB(255, 17, 17, 17),
            surface: Color.fromARGB(211, 201, 182, 91),
            onSurface: Color.fromARGB(255, 107, 107, 107),
          ),
        );
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: Provider.of<ThemeManager>(context).themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: cities.isNotEmpty ? DefaultCities() : Home(),
        );
      },
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
