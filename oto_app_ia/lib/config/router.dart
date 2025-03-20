import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oto_app_ia/features/home/home_screen.dart';
import 'package:oto_app_ia/features/mistral/mistral_screen.dart';
import 'package:oto_app_ia/features/settings/api_key_settings.dart';

/// Configuration du routeur de l'application
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/mistral',
      builder: (context, state) => const MistralScreen(),
    ),
    GoRoute(
      path: '/settings/api-key',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return ApiKeySettings(
          modelId: args?['modelId'] ?? '',
          modelName: args?['modelName'] ?? '',
          apiKeyGuide: args?['apiKeyGuide'] ?? '',
        );
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'Page non trouvée: ${state.uri.path}',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
  ),
); 