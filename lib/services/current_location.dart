import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherweather/Pages/snackbar.dart';

class CurrentLocation extends ChangeNotifier {
  Position? currentPosition;
  Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(context,
          'Location services are disabled. Please enable the services');

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(context, 'Location permissions are denied');

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(context,
          'Location permissions are permanently denied, we cannot request permissions.');

      return false;
    }
    return true;
  }

  Future<Position> getCurrentPosition(context) async {
    final hasPermission = await handleLocationPermission(context);
    if (hasPermission) {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } else {
      showSnackBar(context, 'error occurred');
    }
    notifyListeners();
    return currentPosition!;
  }
}
