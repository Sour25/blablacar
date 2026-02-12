import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';

class LocationPicker extends StatelessWidget {
  final List<Location> locations;

  const LocationPicker({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];

          return ListTile(
            title: Text(location.name),
            subtitle: Text(location.country.name),
            onTap: () {
              Navigator.pop(context, location);
            },
          );
        },
      ),
    );
  }
}
