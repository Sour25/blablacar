import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static const List<Location> availableLocations = fakeLocations;
  // TODO for now fake data
  static List<Location> getAllLocations() {
    return availableLocations;
  }

  //search by name
  static List<Location> searchLocations(String keyword) {
    return availableLocations
        .where(
          (location) =>
              location.name.toLowerCase().contains(keyword.toLowerCase()),
        )
        .toList();
  }
}
