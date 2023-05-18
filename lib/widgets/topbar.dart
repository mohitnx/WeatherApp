import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherweather/Pages/getting_city_name.dart';
import 'package:weatherweather/theme/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
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
    );
  }
}


/*
  TextButton(
    //               child: Text(
    //                 'Refresh',
    //                 style: TextStyle(color: myColor.secondaryColor),
    //               ),
    //               onPressed: () async {
    //                 try {
    //                   final result =
    //                       await InternetAddress.lookup('example.com');
    //                   if (result.isNotEmpty &&
    //                       result[0].rawAddress.isNotEmpty) {
    //                     await Provider.of<CityProvider>(context, listen: false)
    //                         .refreshFunction(context, lat, long);
    //                   }
    //                 } on SocketException catch (_) {
    //                   showSnackBar(context,
    //                       'Check the internet connection and try again');
    //                 }
    //               },
    //             ),
    //           ],
    //         ),
    //       ),

    */