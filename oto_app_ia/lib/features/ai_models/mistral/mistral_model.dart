import 'package:flutter/material.dart';
import 'package:oto_app_ia/core/models/ai_model.dart';

class MistralModel implements AIModel {
  @override
  String get name => 'Mistral AI';

  @override
  String get description =>
      'Un modèle de langage puissant pour la conversation et l\'analyse de texte';

  @override
  IconData get icon => Icons.psychology;

  @override
  String get type => AIModelType.chat.label;

  @override
  String get version => '1.0.0';

  @override
  bool get requiresApiKey => true;

  @override
  String get apiEndpoint => 'https://api.mistral.ai/v1/chat/completions';
}

class MistralService {
  final String _apiKey;

  MistralService(this._apiKey);

  Future<String> generateResponse(String prompt) async {
    // TODO: Implémenter l'appel à l'API Mistral
    throw UnimplementedError();
  }

  Future<void> validateApiKey() async {
    // TODO: Implémenter la validation de la clé API
    throw UnimplementedError();
  }
} 