import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  final Map<String, dynamic> _cache = {};

  ApiService()
      : _dio = Dio(),
        _storage = const FlutterSecureStorage();

  /// Initialise le service avec une clé API
  Future<void> initializeWithApiKey(String modelId, String apiKey) async {
    await _storage.write(key: 'api_key_$modelId', value: apiKey);
  }

  /// Récupère la clé API pour un modèle
  Future<String?> getApiKey(String modelId) async {
    return await _storage.read(key: 'api_key_$modelId');
  }

  /// Effectue un appel API avec mise en cache
  Future<dynamic> makeRequest({
    required String endpoint,
    required String method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? cacheKey,
    Duration cacheDuration = const Duration(minutes: 5),
  }) async {
    // Vérifie si la réponse est en cache
    if (cacheKey != null && _cache.containsKey(cacheKey)) {
      final cachedData = _cache[cacheKey];
      if (cachedData['timestamp'].add(cacheDuration).isAfter(DateTime.now())) {
        return cachedData['data'];
      }
      _cache.remove(cacheKey);
    }

    try {
      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      // Met en cache la réponse si nécessaire
      if (cacheKey != null) {
        _cache[cacheKey] = {
          'data': response.data,
          'timestamp': DateTime.now(),
        };
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Délai d\'attente dépassé');
      case DioExceptionType.badResponse:
        return Exception(
            'Erreur ${error.response?.statusCode}: ${error.response?.statusMessage}');
      case DioExceptionType.cancel:
        return Exception('Requête annulée');
      default:
        return Exception('Une erreur est survenue: ${error.message}');
    }
  }

  /// Nettoie le cache
  void clearCache() {
    _cache.clear();
  }
} 