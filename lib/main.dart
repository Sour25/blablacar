import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repositories/locations_repository.dart';
import 'repositories/rides_repository.dart';
import 'repositories/ride_preference_repository.dart';

import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LocationsRepository>(create: (_) => MockLocationsRepository()),
        Provider<RidesRepository>(create: (_) => MockRidesRepository()),
        Provider<RidePreferenceRepository>(
          create: (_) => MockRidePreferenceRepository(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: Scaffold(body: RidePrefScreen()),
      ),
    );
  }
}
