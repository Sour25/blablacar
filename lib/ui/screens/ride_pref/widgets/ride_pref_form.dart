import 'package:flutter/material.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../widgets/display/bla_divider.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/animations_util.dart';
import '../../../../utils/date_time_util.dart';
import '../../../theme/theme.dart';
import '../../../widgets/inputs/location_picker.dart';
import '../widgets/ride_pref_input.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  Location? arrival;
  late DateTime departureDate;
  late int requestedSeats;

  @override
  void initState() {
    super.initState();

    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------
  // BLA-002: Select locations
  // ----------------------------

  void onDeparturePressed() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        LocationPicker(initLocation: departure),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        LocationPicker(initLocation: arrival),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  // ----------------------------
  // BLA-003: Swap locations
  // ----------------------------

  void onSwappingLocationPressed() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  bool get switchVisible => departure != null || arrival != null;

  // ----------------------------
  // ----------------------------

  void onSubmit() {
    if (departure == null || arrival == null) return;

    final ridePref = RidePref(
      departure: departure!,
      arrival: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );

    Navigator.pop(context, ridePref);
  }

  // ----------------------------
  // ----------------------------

  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";

  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePlaceholder => departure == null;
  bool get showArrivalPlaceholder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);

  String get numberLabel => requestedSeats.toString();

  // ----------------------------
  // BUILD
  // ----------------------------

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              RidePrefInput(
                isPlaceHolder: showDeparturePlaceholder,
                title: departureLabel,
                leftIcon: Icons.location_on,
                onPressed: onDeparturePressed,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed: switchVisible
                    ? onSwappingLocationPressed
                    : null,
              ),
              const BlaDivider(),

              RidePrefInput(
                isPlaceHolder: showArrivalPlaceholder,
                title: arrivalLabel,
                leftIcon: Icons.location_on,
                onPressed: onArrivalPressed,
              ),
              const BlaDivider(),

              RidePrefInput(
                title: dateLabel,
                leftIcon: Icons.calendar_month,
                onPressed: () {},
              ),
              const BlaDivider(),

              RidePrefInput(
                title: numberLabel,
                leftIcon: Icons.person_2_outlined,
                onPressed: () {},
              ),
            ],
          ),
        ),

        BlaButton(label: 'Search', onPressed: onSubmit),
      ],
    );
  }
}
