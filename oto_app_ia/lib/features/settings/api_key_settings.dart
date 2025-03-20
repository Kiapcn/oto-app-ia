import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:oto_app_ia/config/theme.dart';
import 'package:oto_app_ia/core/services/api_config_service.dart';
import 'package:oto_app_ia/shared/widgets/info_tooltip.dart';

class ApiKeySettings extends StatefulWidget {
  final String modelId;
  final String modelName;
  final String apiKeyGuide;

  const ApiKeySettings({
    super.key,
    required this.modelId,
    required this.modelName,
    required this.apiKeyGuide,
  });

  @override
  State<ApiKeySettings> createState() => _ApiKeySettingsState();
}

class _ApiKeySettingsState extends State<ApiKeySettings> {
  final _apiConfigService = ApiConfigService();
  final _apiKeyController = TextEditingController();
  bool _useCustomKey = false;
  bool _isLoading = true;
  bool _showApiKey = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final useCustom = await _apiConfigService.isUsingCustomKey(widget.modelId);
    if (useCustom) {
      final key = await _apiConfigService.getApiKey(widget.modelId);
      _apiKeyController.text = key;
    }
    setState(() {
      _useCustomKey = useCustom;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuration ${widget.modelName}'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildApiKeySection(),
                  if (_useCustomKey) ...[
                    const SizedBox(height: 24),
                    _buildApiKeyInput(),
                  ],
                  const SizedBox(height: 32),
                  _buildGuideSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configuration de l\'API',
          style: Theme.of(context).textTheme.headlineSmall,
        ).animate().fadeIn().slideX(),
        const SizedBox(height: 8),
        Text(
          'Choisissez entre utiliser la clé API par défaut ou votre propre clé.',
          style: Theme.of(context).textTheme.bodyLarge,
        ).animate().fadeIn().slideX(delay: 200.ms),
      ],
    );
  }

  Widget _buildApiKeySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Utiliser ma propre clé API',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 8),
                HelpIcon(
                  message: 'Activez cette option pour utiliser votre propre clé API '
                      'au lieu de la clé par défaut. Cela vous donnera un meilleur '
                      'contrôle sur vos requêtes et leur facturation.',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Switch.adaptive(
              value: _useCustomKey,
              onChanged: (value) async {
                setState(() => _useCustomKey = value);
                if (!value) {
                  await _apiConfigService.resetToDefaultKey(widget.modelId);
                  _apiKeyController.clear();
                }
              },
            ),
            if (!_useCustomKey) ...[
              const SizedBox(height: 8),
              Text(
                'Vous utilisez actuellement la clé API par défaut.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textTertiaryColor,
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn().slideX(delay: 400.ms);
  }

  Widget _buildApiKeyInput() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Votre clé API',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 8),
                HelpIcon(
                  message: 'La clé API est nécessaire pour authentifier vos '
                      'requêtes auprès du service. Ne partagez jamais votre '
                      'clé API avec d\'autres personnes.',
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _apiKeyController,
              obscureText: !_showApiKey,
              decoration: InputDecoration(
                hintText: 'Entrez votre clé API',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        _showApiKey ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => _showApiKey = !_showApiKey);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: _saveApiKey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(delay: 600.ms);
  }

  Widget _buildGuideSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb_outline),
                const SizedBox(width: 8),
                Text(
                  'Guide d\'obtention de la clé API',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.apiKeyGuide,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(delay: 800.ms);
  }

  Future<void> _saveApiKey() async {
    final apiKey = _apiKeyController.text.trim();
    if (apiKey.isEmpty) {
      _showError('La clé API ne peut pas être vide');
      return;
    }

    if (!_apiConfigService.isValidApiKey(apiKey)) {
      _showError('Format de clé API invalide');
      return;
    }

    try {
      await _apiConfigService.saveCustomApiKey(widget.modelId, apiKey);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Clé API enregistrée avec succès'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      _showError('Erreur lors de l\'enregistrement de la clé API');
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }
} 