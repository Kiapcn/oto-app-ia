import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:oto_app_ia/config/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('oTo App IA'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenue sur oTo App IA',
              style: Theme.of(context).textTheme.headlineMedium,
            ).animate().fadeIn().slideX(),
            const SizedBox(height: 16),
            Text(
              'Votre interface unifiée pour l\'IA',
              style: Theme.of(context).textTheme.titleLarge,
            ).animate().fadeIn().slideX(delay: 200.ms),
            const SizedBox(height: 32),
            _buildModelGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildModelGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _ModelCard(
          title: 'Mistral AI',
          description: 'Chat avec Mistral AI',
          icon: Icons.chat_bubble_outline,
          onTap: () => context.push('/mistral'),
        ),
        // Ajoutez d'autres cartes pour les futurs modèles ici
      ],
    ).animate().fadeIn().slideY(delay: 400.ms);
  }
}

class _ModelCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _ModelCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 