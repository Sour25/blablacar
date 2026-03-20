import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';

abstract class LocationsRepository {
  List<Location> getAllLocations();
  List<Location> searchLocations(String keyword);
}

class MockLocationsRepository implements LocationsRepository {
  final List<Location> _locations = fakeLocations;

  @override
  List<Location> getAllLocations() {
    return _locations;
  }

  @override
  List<Location> searchLocations(String keyword) {
    return _locations
        .where(
          (location) =>
              location.name.toLowerCase().contains(keyword.toLowerCase()),
        )
        .toList();
  }
}
