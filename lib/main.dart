import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weatherweather/Pages/default_cities.dart';
import 'package:weatherweather/Provider/citiy_provider_two.dart';
import 'package:weatherweather/Provider/city_provider.dart';
import 'package:weatherweather/Provider/notification_provider.dart';

import 'package:weatherweather/theme/theme_manager.dart';

import 'services/current_location.dart';

// Constants myConstants = Constants();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<List>('cities');

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
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeManager>(create: (context) => ThemeManager()),
    ChangeNotifierProvider<CityProvider>(create: (context) => CityProvider()),

    ChangeNotifierProvider<CityProvider2>(create: (context) => CityProvider2()),
    ChangeNotifierProvider<NotiProvider>(
      create: (context) => NotiProvider(),
    ),
    //CurrentLocation
    ChangeNotifierProvider<CurrentLocation>(
      create: (context) => CurrentLocation(),
    ),
  ], child: MyApp()));
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
          home: DefaultCities(),
        );
      },
    );
  }
}
