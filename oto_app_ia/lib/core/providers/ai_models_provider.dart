import 'package:flutter/material.dart';
import 'package:oto_app_ia/core/models/ai_model.dart';
import 'package:oto_app_ia/features/ai_models/mistral/mistral_model.dart';

class AIModelsProvider extends ChangeNotifier {
  final List<AIModel> _availableModels = [
    MistralModel(),
    // Autres modèles à ajouter ici
  ];

  List<AIModel> get availableModels => _availableModels;

  AIModel? getModelByType(AIModelType type) {
    try {
      return _availableModels.firstWhere((model) => model.type == type.label);
    } catch (e) {
      return null;
    }
  }

  AIModel? getModelByName(String name) {
    try {
      return _availableModels.firstWhere(
        (model) => model.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // État des clés API
  final Map<String, String> _apiKeys = {};

  Future<void> setApiKey(String modelName, String apiKey) async {
    _apiKeys[modelName] = apiKey;
    notifyListeners();
  }

  String? getApiKey(String modelName) => _apiKeys[modelName];

  bool hasApiKey(String modelName) => _apiKeys.containsKey(modelName);
} 