# oTo-app-IA

## État d'avancement du projet

### Configuration et Structure de Base ✅
- [x] Création du projet Flutter
- [x] Configuration des dépendances
- [x] Structure des dossiers
- [x] Configuration du thème "Pencil Paper"
- [x] Page d'accueil de base

### Architecture des Modèles d'IA ✅
- [x] Interface de base AIModel
- [x] Service API générique
- [x] Système de gestion des clés API
- [x] Structure modulaire pour les modèles
- [x] Provider pour la gestion d'état

### Intégration de Mistral AI 🚧
- [x] Implémentation du modèle Mistral
- [x] Interface utilisateur de chat
- [ ] Intégration complète de l'API
- [ ] Gestion des paramètres et clés API
- [ ] Tests d'intégration

### Navigation et Routing ✅
- [x] Configuration de GoRouter
- [x] Navigation entre les modèles
- [x] Gestion des états de navigation
- [x] Page d'erreur 404

### Fonctionnalités Additionnelles ⏳
- [x] Système de cache intelligent
- [ ] Mode hors ligne
- [ ] Historique des conversations
- [ ] Export des résultats

### UI/UX 🚧
- [x] Animations de base
- [ ] Mode sombre/clair
- [x] Responsive design de base
- [ ] Accessibilité

### Documentation 🚧
- [x] Structure du projet
- [ ] Documentation API
- [ ] Guide d'utilisation
- [ ] Guide de contribution

Légende:
- ✅ Terminé
- 🚧 En cours
- ⏳ À faire

Etape 1
Description du Projet
oTo-app-IA est une application mobile qui sert d'interface unifiée pour accéder à une multitude de modèles d'intelligence artificielle open source. L'application permet aux utilisateurs d'interagir avec différents modèles d'IA via une interface simple, élégante et intuitive, sans avoir à installer plusieurs applications ou à configurer des environnements complexes.
L'interface suit un design "Pencil Paper" minimaliste, utilisant principalement des nuances de noir, blanc et gris, avec des animations subtiles pour améliorer l'expérience utilisateur.
Fonctionnalités Principales

Page d'accueil explicative : Présentation du concept et navigation intuitive
Système de blocs d'IA : Chaque modèle d'IA est représenté par un bloc interactif
Interface dédiée par IA : Chaque modèle dispose d'une interface adaptée à ses fonctionnalités
Architecture extensible : Possibilité d'ajouter facilement de nouveaux modèles d'IA
Design épuré et élégant : Interface "Pencil Paper" avec animations subtiles
Utilisation d'API distantes : Les modèles s'exécutent sur des serveurs, pas sur l'appareil

Design et Expérience Utilisateur

Style "Pencil Paper" : Interface minimaliste rappelant un carnet de notes
Palette de couleurs : Noir, blanc et nuances de gris pour une esthétique épurée
Microinteractions : Animations légères en réponse aux actions de l'utilisateur
Éléments en relief : Utilisation subtile d'ombres et de reliefs pour la hiérarchie visuelle
Interface responsive : Adaptation fluide à différentes tailles d'écran

Architecture Technique
Frontend (Flutter)

Architecture MVVM (Model-View-ViewModel)
Gestion d'état avec Provider
Navigation avec GoRouter
Animations fluides avec Flutter animations

Backend (API)

Communication avec différentes API d'IA
Système de gestion des tokens et des quotas
Cache intelligent pour optimiser les performances

Modèles d'IA supportés (initialement)

Modèles de conversation (LLM)
Modèles de génération d'images
Modèles de reconnaissance vocale
Modèles de traduction

Installation et Configuration
Prérequis

Flutter 3.10.0 ou supérieur
Dart 3.0.0 ou supérieur
Un éditeur comme VS Code ou Android Studio

Installation

Clonez ce dépôt

bashCopiergit clone https://github.com/votre-nom/oTo-app-IA.git

Installez les dépendances

bashCopiercd oTo-app-IA
flutter pub get

Lancez l'application

bashCopierflutter run
Structure du Projet
CopieroTo-app-IA/
├── lib/               # Code source principal
│   ├── config/        # Configuration de l'application
│   ├── core/          # Logique métier, API, services
│   ├── features/      # Fonctionnalités par module
│   └── shared/        # Widgets et utilitaires partagés
├── assets/            # Ressources (images, fonts)
└── test/              # Tests unitaires et d'intégration
Contribuer au Projet
Les contributions sont les bienvenues ! Voici comment vous pouvez contribuer :

Ajouter le support pour de nouveaux modèles d'IA
Améliorer l'interface utilisateur
Optimiser les performances
Ajouter de nouvelles fonctionnalités

Roadmap

v0.1 : MVP avec support pour 5 modèles d'IA
v0.2 : Amélioration de l'UI et ajout de 10 modèles supplémentaires
v0.3 : Ajout de fonctionnalités sociales et de partage
v1.0 : Version stable avec support pour 50+ modèles d'IA

Licence
Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.

Prompt pour Cursor - Création du projet oTo-app-IA
Contexte du projet
Je souhaite créer une application mobile Flutter nommée "oTo-app-IA" qui servira d'interface unifiée pour accéder à une multitude de modèles d'intelligence artificielle open source. L'application permettra aux utilisateurs d'interagir avec différents modèles d'IA via une interface simple, élégante et intuitive.
Design souhaité

Style "Pencil Paper" minimaliste
Palette de couleurs: noir, blanc et nuances de gris
Animations subtiles pour les interactions
Interface épurée mais avec du relief pour la hiérarchie visuelle

Structure de l'application

Une page d'accueil explicative du concept
Système de blocs représentant chaque IA disponible
Interface dédiée par IA après avoir cliqué sur un bloc
Architecture permettant d'ajouter facilement de nouveaux modèles d'IA

Technologies à utiliser

Flutter pour le développement cross-platform
Provider pour la gestion d'état
Dio pour les appels API
Hive pour le stockage local
GoRouter pour la navigation

Actions à réaliser

Créer la structure de dossiers complète du projet
Développer les fichiers de base nécessaires au fonctionnement de l'application
Implémenter le thème "Pencil Paper" en noir et blanc avec nuances de gris
Créer les composants principaux pour la page d'accueil et l'interface de chat
Mettre en place l'architecture pour communiquer avec les APIs d'IA

Structure de dossiers souhaitée
CopieroTo-app-IA/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── config/
│   │   ├── app_config.dart
│   │   ├── theme.dart
│   │   └── constants.dart
│   ├── core/
│   │   ├── api/
│   │   ├── models/
│   │   ├── services/
│   │   └── utils/
│   ├── features/
│   │   ├── home/
│   │   ├── onboarding/
│   │   ├── ai_chat/
│   │   └── settings/
│   └── shared/
│       ├── widgets/
│       └── layouts/
├── assets/
│   ├── images/
│   └── fonts/
└── test/
Fonctionnalités principales à implémenter

Écran d'accueil avec explication du concept et grille de blocs d'IA
Interface de chat adaptée à chaque type d'IA
Service d'API pour communiquer avec les différents modèles d'IA
Système de gestion et d'ajout de nouveaux modèles

Détails supplémentaires sur le design

Les blocs d'IA doivent avoir un léger effet d'élévation
Utiliser des animations subtiles pour les transitions entre écrans
Interface de chat inspirée des applications de notes manuscrites
Privilégier les bords légèrement arrondis pour les éléments d'interface

Merci de m'aider à créer ce projet en utilisant la structure et les spécifications décrites ci-dessus.


Etape 2
## Architecture d'intégration des modèles d'IA

### Structure modulaire
L'application utilise une architecture modulaire où chaque modèle d'IA est encapsulé dans son propre module, ce qui permet:
- Une intégration facile de nouveaux modèles
- Une indépendance entre les différentes interfaces
- Une maintenance simplifiée

### Communication avec les API externes
- Utilisation d'une couche d'abstraction pour uniformiser les appels API
- Système de mise en cache intelligent pour réduire la latence
- Gestion optimisée des tokens et des limites d'utilisation

## Guide d'intégration d'un nouveau modèle d'IA
Pour ajouter un nouveau modèle (comme Mistral AI) à l'application:

1. Créer un nouveau dossier dans `lib/features/[nom_du_modele]`
2. Implémenter les fichiers suivants:
   - `[model]_service.dart`: Pour la communication avec l'API
   - `[model]_view_model.dart`: Pour la logique business
   - `[model]_screen.dart`: Pour l'interface utilisateur
3. Enregistrer le modèle dans le système de routing
4. Ajouter un bloc représentant le modèle sur la page d'accueil

## Configuration des clés API
L'application utilise un système sécurisé pour gérer les clés API:
- Stockage sécurisé des clés avec flutter_secure_storage
- Option pour les utilisateurs d'utiliser leurs propres clés API
- Système de proxy pour les modèles qui le permettent

Prompt pour Cursor AI : Intégration de Mistral AI dans oTo-app-IA
Aide-moi à créer les fichiers nécessaires pour intégrer Mistral AI dans mon application Flutter oTo-app-IA. L'application sert d'interface unifiée pour accéder à des modèles d'IA open source via des API distantes.
Je souhaite créer une page dédiée à Mistral AI avec une interface minimaliste "Pencil Paper", utilisant principalement des nuances de noir, blanc et gris.
Voici ce dont j'ai besoin :

Un service API (mistral_service.dart) pour communiquer avec l'API Mistral AI qui:

Gère l'authentification avec la clé API
Permet d'envoyer des requêtes au modèle
Traite les réponses de manière asynchrone
Implémente un système de mise en cache approprié


Un ViewModel (mistral_view_model.dart) qui:

Utilise l'architecture MVVM
Gère l'état de la conversation
Fournit des méthodes pour interagir avec le service


Une interface utilisateur (mistral_screen.dart) qui:

Suit le design "Pencil Paper" minimaliste
Affiche une interface de chat avec entrée texte et historique
Inclut des animations subtiles en réponse aux actions utilisateur
Permette de choisir entre différents modèles de Mistral
Affiche un indicateur de chargement pendant le traitement


Mise à jour du système de routing pour inclure cette nouvelle page
Un bloc représentant Mistral AI pour la page d'accueil

Assure-toi que l'intégration est légère, car l'application ne doit pas devenir lourde à mesure que j'ajoute des modèles d'IA. Tout le traitement doit être effectué côté serveur via l'API, l'application servant uniquement d'interface.
Utilise les bonnes pratiques Flutter, l'architecture MVVM et le gestionnaire d'état Provider conformément à la structure existante du projet.