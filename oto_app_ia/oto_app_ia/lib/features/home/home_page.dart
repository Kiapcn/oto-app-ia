import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('oTo App IA'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // TODO: Implémenter la page d'aide
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildFeatureBlocks(context),
            _buildAdvantagesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(
            Icons.psychology_outlined,
            size: 80,
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(delay: 200.ms),
          const SizedBox(height: 24),
          Text(
            'Votre Interface Unifiée pour l\'IA',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 16),
          Text(
            'Accédez à de multiples modèles d\'IA open source à travers une interface simple et élégante',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: Implémenter la navigation vers les modèles
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Text('Explorer les Modèles'),
            ),
          ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildFeatureBlocks(BuildContext context) {
    final features = [
      {
        'icon': Icons.chat_bubble_outline,
        'title': 'Conversation',
        'description': 'Dialoguez avec différents modèles de langage'
      },
      {
        'icon': Icons.image_outlined,
        'title': 'Génération d\'Images',
        'description': 'Créez des images à partir de descriptions textuelles'
      },
      {
        'icon': Icons.record_voice_over_outlined,
        'title': 'Reconnaissance Vocale',
        'description': 'Convertissez la parole en texte avec précision'
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Modèles Disponibles',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    // TODO: Naviguer vers le modèle spécifique
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          features[index]['icon'] as IconData,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          features[index]['title'] as String,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          features[index]['description'] as String,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: (300 * index).ms).slideX();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvantagesSection(BuildContext context) {
    final advantages = [
      {
        'icon': Icons.speed_outlined,
        'title': 'Performance',
        'description': 'Accès rapide et optimisé aux modèles'
      },
      {
        'icon': Icons.security_outlined,
        'title': 'Sécurité',
        'description': 'Vos données sont protégées'
      },
      {
        'icon': Icons.devices_outlined,
        'title': 'Multi-plateforme',
        'description': 'Utilisable sur tous vos appareils'
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Pourquoi Choisir oTo App IA',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(),
          const SizedBox(height: 24),
          ...advantages.map((advantage) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Icon(advantage['icon'] as IconData, size: 32),
                  title: Text(advantage['title'] as String),
                  subtitle: Text(advantage['description'] as String),
                ).animate().fadeIn().slideX(),
              )),
        ],
      ),
    );
  }
} 