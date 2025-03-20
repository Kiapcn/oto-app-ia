import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConfigService {
  static const String _defaultMistralKey = 'YOUR_DEFAULT_KEY'; // À remplacer par votre clé par défaut
  final FlutterSecureStorage _secureStorage;
  
  ApiConfigService() : _secureStorage = const FlutterSecureStorage();

  // Clés de stockage
  static const String _useCustomKeyPref = 'use_custom_key_';
  static const String _apiKeyStorage = 'api_key_';

  /// Vérifie si l'utilisateur utilise une clé personnalisée pour un modèle donné
  Future<bool> isUsingCustomKey(String modelId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('${_useCustomKeyPref}$modelId') ?? false;
  }

  /// Définit si l'utilisateur utilise une clé personnalisée
  Future<void> setUseCustomKey(String modelId, bool useCustom) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${_useCustomKeyPref}$modelId', useCustom);
  }

  /// Récupère la clé API pour un modèle
  Future<String> getApiKey(String modelId) async {
    final useCustomKey = await isUsingCustomKey(modelId);
    if (useCustomKey) {
      final customKey = await _secureStorage.read(key: '${_apiKeyStorage}$modelId');
      if (customKey != null && customKey.isNotEmpty) {
        return customKey;
      }
    }
    // Retourne la clé par défaut si pas de clé personnalisée
    return _getDefaultKey(modelId);
  }

  /// Enregistre une clé API personnalisée
  Future<void> saveCustomApiKey(String modelId, String apiKey) async {
    await _secureStorage.write(key: '${_apiKeyStorage}$modelId', value: apiKey);
    await setUseCustomKey(modelId, true);
  }

  /// Supprime la clé API personnalisée et revient à la clé par défaut
  Future<void> resetToDefaultKey(String modelId) async {
    await _secureStorage.delete(key: '${_apiKeyStorage}$modelId');
    await setUseCustomKey(modelId, false);
  }

  /// Retourne la clé par défaut pour un modèle donné
  String _getDefaultKey(String modelId) {
    switch (modelId) {
      case 'mistral':
        return _defaultMistralKey;
      default:
        throw Exception('Modèle non supporté: $modelId');
    }
  }

  /// Vérifie si une clé API est valide (à implémenter selon les critères de chaque API)
  bool isValidApiKey(String apiKey) {
    // Exemple de validation basique
    return apiKey.length >= 32 && apiKey.length <= 64;
  }

  /// Récupère la clé API appropriée (personnalisée ou par défaut) pour le modèle
  Future<String> getEffectiveApiKey(String modelId, String defaultKey) async {
    if (await isUsingCustomKey(modelId)) {
      final customKey = await getApiKey(modelId);
      if (customKey.isNotEmpty) {
        return customKey;
      }
    }
    return defaultKey;
  }
} 