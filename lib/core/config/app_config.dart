class AppConfig {
  const AppConfig._();

  static const mapTilerApiKey = String.fromEnvironment('MAPTILER_API_KEY');

  static const defaultLatitude = 10.7769;
  static const defaultLongitude = 106.7009;
  static const defaultZoom = 13.0;
  static const maxImagesPerMemory = 5;

  static String get mapTileUrl =>
      'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=$mapTilerApiKey';

  static Uri geocodingUri(String query) {
    return Uri.https(
      'api.maptiler.com',
      '/geocoding/$query.json',
      {
        'key': mapTilerApiKey,
        'limit': '6',
        'language': 'vi,en',
      },
    );
  }

  static bool get hasMapTilerKey => mapTilerApiKey.isNotEmpty;
}
