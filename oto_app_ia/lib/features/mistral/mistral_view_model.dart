import 'package:flutter/material.dart';
import 'package:oto_app_ia/features/mistral/mistral_service.dart';

class Message {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  Message({
    required this.content,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class MistralViewModel extends ChangeNotifier {
  final MistralService _service;
  final List<Message> _messages = [];
  List<String> _availableModels = [];
  String _selectedModel = 'mistral-tiny';
  bool _isLoading = false;
  String _error = '';

  MistralViewModel() : _service = MistralService() {
    _loadModels();
  }

  List<Message> get messages => List.unmodifiable(_messages);
  List<String> get availableModels => _availableModels;
  String get selectedModel => _selectedModel;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> _loadModels() async {
    try {
      _availableModels = await _service.getAvailableModels();
      notifyListeners();
    } catch (e) {
      _error = 'Erreur lors du chargement des modèles: $e';
      notifyListeners();
    }
  }

  void setModel(String model) {
    _selectedModel = model;
    notifyListeners();
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // Ajoute le message de l'utilisateur
    _messages.add(Message(content: content, isUser: true));
    notifyListeners();

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await _service.sendMessage(
        content,
        model: _selectedModel,
      );

      final assistantMessage = response['choices'][0]['message']['content'] as String;
      _messages.add(Message(content: assistantMessage, isUser: false));
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChat() {
    _messages.clear();
    _error = '';
    notifyListeners();
  }
} 