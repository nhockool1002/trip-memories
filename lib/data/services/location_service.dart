import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  Future<LatLng> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException();
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw PermissionDeniedException('Quyền vị trí bị từ chối.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw PermissionDeniedException(
        'Quyền vị trí bị từ chối vĩnh viễn. Vui lòng mở Settings để cấp lại.',
      );
    }

    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}
