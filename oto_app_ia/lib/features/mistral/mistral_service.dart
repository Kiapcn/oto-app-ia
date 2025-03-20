import 'package:dio/dio.dart';
import 'package:oto_app_ia/core/services/api_config_service.dart';

class MistralService {
  final Dio _dio;
  final ApiConfigService _apiConfigService;
  static const String _baseUrl = 'https://api.mistral.ai/v1';

  MistralService()
      : _dio = Dio(BaseOptions(baseUrl: _baseUrl)),
        _apiConfigService = ApiConfigService();

  Future<void> _configureHeaders() async {
    final apiKey = await _apiConfigService.getApiKey('mistral');
    _dio.options.headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };
  }

  Future<Map<String, dynamic>> sendMessage(String message, {
    String model = 'mistral-tiny',
    double temperature = 0.7,
    int maxTokens = 1000,
  }) async {
    await _configureHeaders();
    
    try {
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': model,
          'messages': [
            {'role': 'user', 'content': message}
          ],
          'temperature': temperature,
          'max_tokens': maxTokens,
        },
      );
      
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Clé API invalide. Veuillez vérifier vos paramètres.');
      }
      throw Exception('Erreur lors de la communication avec Mistral AI: ${e.message}');
    }
  }

  Future<List<String>> getAvailableModels() async {
    await _configureHeaders();
    
    try {
      final response = await _dio.get('/models');
      final models = (response.data['data'] as List)
          .map((model) => model['id'] as String)
          .toList();
      return models;
    } catch (e) {
      return ['mistral-tiny', 'mistral-small', 'mistral-medium'];
    }
  }
} 