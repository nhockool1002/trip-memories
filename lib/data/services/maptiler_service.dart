import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';
import '../models/map_search_result.dart';

class MapTilerService {
  const MapTilerService({http.Client? client}) : _client = client;

  final http.Client? _client;

  Future<List<MapSearchResult>> searchPlaces(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.length < 2 || !AppConfig.hasMapTilerKey) {
      return const [];
    }

    final client = _client ?? http.Client();
    final response = await client.get(AppConfig.geocodingUri(trimmedQuery));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw MapTilerException('MapTiler search failed: ${response.statusCode}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final features = body['features'] as List<dynamic>? ?? const [];
    return features
        .whereType<Map<String, dynamic>>()
        .map(MapSearchResult.fromMapTilerFeature)
        .toList();
  }
}

class MapTilerException implements Exception {
  const MapTilerException(this.message);

  final String message;

  @override
  String toString() => message;
}
