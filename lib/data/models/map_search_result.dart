import 'package:latlong2/latlong.dart';

class MapSearchResult {
  const MapSearchResult({
    required this.id,
    required this.name,
    required this.coordinate,
    this.address,
  });

  final String id;
  final String name;
  final String? address;
  final LatLng coordinate;

  factory MapSearchResult.fromMapTilerFeature(Map<String, dynamic> feature) {
    final geometry = feature['geometry'] as Map<String, dynamic>;
    final coordinates = geometry['coordinates'] as List<dynamic>;
    final placeName = feature['place_name'] as String?;
    final text = feature['text'] as String?;

    return MapSearchResult(
      id: feature['id'] as String? ?? placeName ?? text ?? coordinates.join(','),
      name: text ?? placeName ?? 'Địa điểm chưa đặt tên',
      address: placeName,
      coordinate: LatLng(
        (coordinates[1] as num).toDouble(),
        (coordinates[0] as num).toDouble(),
      ),
    );
  }
}
