import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:flutter/services.dart';

class Location {
  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        openSnackBar(
            context,
            'Location services are disabled, we cannot request permissions.',
            AnimatedSnackBarType.warning);
      }

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          openSnackBar(context, 'Location permissions are denied',
              AnimatedSnackBarType.warning);
        }
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        openSnackBar(
            context,
            'Location permissions are permanently denied, we cannot request permissions.',
            AnimatedSnackBarType.warning);
      }
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;
    bool requestPermission = false;
    if (serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        requestPermission = true;
      } else {
        requestPermission = false;
      }
    }
    return requestPermission;
  }
}
