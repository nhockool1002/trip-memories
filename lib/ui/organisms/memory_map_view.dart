import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../core/config/app_config.dart';
import '../../data/models/memory_item.dart';

class MemoryMapView extends StatelessWidget {
  const MemoryMapView({
    required this.mapController,
    required this.memories,
    required this.onLongPress,
    required this.onMemoryTap,
    super.key,
    this.currentLocation,
  });

  final MapController mapController;
  final List<MemoryItem> memories;
  final LatLng? currentLocation;
  final ValueChanged<LatLng> onLongPress;
  final ValueChanged<MemoryItem> onMemoryTap;

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[
      if (currentLocation != null)
        Marker(
          point: currentLocation!,
          width: 44,
          height: 44,
          child: Icon(
            Icons.my_location,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
        ),
      ...memories.map(
        (memory) => Marker(
          point: LatLng(memory.latitude, memory.longitude),
          width: 48,
          height: 48,
          child: IconButton.filled(
            tooltip: memory.title,
            onPressed: () => onMemoryTap(memory),
            icon: const Icon(Icons.place),
          ),
        ),
      ),
    ];

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(
          AppConfig.defaultLatitude,
          AppConfig.defaultLongitude,
        ),
        initialZoom: AppConfig.defaultZoom,
        onLongPress: (_, point) => onLongPress(point),
      ),
      children: [
        TileLayer(
          urlTemplate: AppConfig.mapTileUrl,
          userAgentPackageName: 'com.tripmemories.app',
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }
}
