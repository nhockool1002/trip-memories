import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/services/location_service.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final locationControllerProvider =
    AsyncNotifierProvider<LocationController, LatLng?>(
  LocationController.new,
);

class LocationController extends AsyncNotifier<LatLng?> {
  late final LocationService _locationService;

  @override
  Future<LatLng?> build() async {
    _locationService = ref.watch(locationServiceProvider);
    return null;
  }

  Future<void> requestCurrentLocation() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_locationService.getCurrentLocation);
  }
}
