import 'package:flutter/material.dart';
import 'package:blablacar/services/locations_service.dart';
import '../../../model/ride/locations.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key, required this.initLocation});

  final Location? initLocation;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String currentSearchText = "";

  @override
  void initState() {
    super.initState();

    if (widget.initLocation != null) {
      currentSearchText = widget.initLocation!.name;
    }
  }

  void onSearchChanged(String value) {
    setState(() {
      currentSearchText = value;
    });
  }

  void onTap(Location location) {
    Navigator.pop(context, location);
  }

  List<Location> get filteredLocations {
    if (currentSearchText.length < 2) {
      return [];
    }

    return LocationsService.availableLocations
        .where(
          (location) => location.name.toUpperCase().contains(
            currentSearchText.toUpperCase(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: onSearchChanged,
              decoration: const InputDecoration(hintText: "Search location..."),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final location = filteredLocations[index];

                return ListTile(
                  title: Text(location.name),
                  subtitle: Text(location.country.name),
                  onTap: () => onTap(location),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
