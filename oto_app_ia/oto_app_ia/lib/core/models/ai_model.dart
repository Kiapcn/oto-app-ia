import 'package:flutter/material.dart';

/// Interface de base pour tous les modèles d'IA
abstract class AIModel {
  /// Nom du modèle
  String get name;

  /// Description du modèle
  String get description;

  /// Icône représentant le modèle
  IconData get icon;

  /// Type de modèle (chat, image, voix, etc.)
  String get type;

  /// Version du modèle
  String get version;

  /// Indique si le modèle nécessite une clé API
  bool get requiresApiKey;

  /// URL de l'endpoint API
  String get apiEndpoint;
}

/// Types de modèles d'IA disponibles
enum AIModelType {
  chat('Chat'),
  image('Image'),
  voice('Voix'),
  translation('Traduction');

  final String label;
  const AIModelType(this.label);
} 