import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

abstract class RidesRepository {
  List<Ride> getAllRides();
  List<Ride> filterBy({Location? departure, int? seatRequested});
}

class MockRidesRepository implements RidesRepository {
  final List<Ride> _rides = fakeRides;

  @override
  List<Ride> getAllRides() {
    return _rides;
  }

  @override
  List<Ride> filterBy({Location? departure, int? seatRequested}) {
    List<Ride> rides = _rides;

    if (departure != null) {
      rides = rides
          .where((ride) => ride.departureLocation == departure)
          .toList();
    }

    if (seatRequested != null) {
      rides = rides
          .where((ride) => ride.availableSeats >= seatRequested)
          .toList();
    }

    return rides;
  }
}
