import 'package:flutter/services.dart';

class EnvLoader {
  final Map<String, String> _env = {};

  EnvLoader();

  Future<void> loadFromAsset(String assetPath) async {
    final content = await rootBundle.loadString(assetPath);
    final lines = content.split('\n');
    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty || line.startsWith('#')) continue;
      final idx = line.indexOf('=');
      if (idx == -1) continue;
      final key = line.substring(0, idx).trim();
      final value = line.substring(idx + 1).trim();
      _env[key] = value;
    }
  }

  String get(String key) => _env[key] ?? '';

  Uri? makeHttpUri(
    String key, {
    String path = '',
    Map<String, String>? queryParameters,
  }) {
    final baseUrl = get(key);
    print(
      'EnvLoader.makeHttpUri: baseUrl=$baseUrl, path=$path, queryParameters=$queryParameters',
    );
    return Uri.parse(
      baseUrl,
    ).replace(path: path, queryParameters: queryParameters);
  }
}

class Env {
  static late final EnvLoader loader;

  static Future<void> init() async {
    loader = EnvLoader();
    await loader.loadFromAsset('lib/app/assets/.env');
  }
}
