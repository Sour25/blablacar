import '../dummy_data/dummy_data.dart';
import '../model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {
  List<RidePref> getHistory();
  void addPreference(RidePref pref);
}

class MockRidePreferenceRepository implements RidePreferenceRepository {
  final List<RidePref> _history = List.from(fakeRidePrefs);

  @override
  List<RidePref> getHistory() {
    return _history;
  }

  @override
  void addPreference(RidePref pref) {
    _history.insert(0, pref); // latest first
  }
}
