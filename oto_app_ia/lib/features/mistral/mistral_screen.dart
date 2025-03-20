import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:oto_app_ia/config/theme.dart';
import 'package:oto_app_ia/features/mistral/mistral_view_model.dart';
import 'package:oto_app_ia/shared/widgets/info_tooltip.dart';
import 'package:provider/provider.dart';

class MistralScreen extends StatelessWidget {
  const MistralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MistralViewModel(),
      child: const _MistralScreenContent(),
    );
  }
}

class _MistralScreenContent extends StatefulWidget {
  const _MistralScreenContent();

  @override
  State<_MistralScreenContent> createState() => _MistralScreenContentState();
}

class _MistralScreenContentState extends State<_MistralScreenContent> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mistral AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/settings/api-key',
                arguments: {
                  'modelId': 'mistral',
                  'modelName': 'Mistral AI',
                  'apiKeyGuide': 'Pour obtenir votre clé API Mistral AI:\n'
                      '1. Visitez https://console.mistral.ai\n'
                      '2. Créez un compte ou connectez-vous\n'
                      '3. Accédez à la section "API Keys"\n'
                      '4. Cliquez sur "Create New Key"',
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildModelSelector(),
          Expanded(
            child: Container(
              color: AppTheme.surfaceLightColor,
              child: _buildChatArea(),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildModelSelector() {
    return Consumer<MistralViewModel>(
      builder: (context, viewModel, _) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            border: Border(
              bottom: BorderSide(
                color: AppTheme.surfaceDarkColor,
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.all(AppTheme.spacingUnit * 2),
          child: Row(
            children: [
              const Text(
                'Modèle:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: AppTheme.spacingUnit),
              DropdownButton<String>(
                value: viewModel.selectedModel,
                items: viewModel.availableModels
                    .map((model) => DropdownMenuItem(
                          value: model,
                          child: Text(model),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) viewModel.setModel(value);
                },
                underline: Container(),
                elevation: 2,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
              ),
              const Spacer(),
              InfoTooltip(
                message: 'Choisissez le modèle Mistral à utiliser.\n'
                    'Les modèles plus grands sont plus performants '
                    'mais consomment plus de tokens.',
                child: const Icon(
                  Icons.help_outline,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
        ).animate().fadeIn().slideY(begin: -0.2);
      },
    );
  }

  Widget _buildChatArea() {
    return Consumer<MistralViewModel>(
      builder: (context, viewModel, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        
        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingUnit * 3,
            vertical: AppTheme.spacingUnit * 2,
          ),
          itemCount: viewModel.messages.length,
          itemBuilder: (context, index) {
            final message = viewModel.messages[index];
            return _MessageBubble(message: message)
                .animate()
                .fadeIn()
                .slideY(begin: 0.2);
          },
        );
      },
    );
  }

  Widget _buildInputArea() {
    return Consumer<MistralViewModel>(
      builder: (context, viewModel, _) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadowColor,
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.all(AppTheme.spacingUnit * 2)
              .copyWith(bottom: AppTheme.spacingUnit * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (viewModel.error.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(
                    bottom: AppTheme.spacingUnit * 2,
                  ),
                  padding: const EdgeInsets.all(AppTheme.spacingUnit * 2),
                  decoration: BoxDecoration(
                    color: AppTheme.errorColor.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(AppTheme.borderRadiusMedium),
                  ),
                  child: Text(
                    viewModel.error,
                    style: TextStyle(
                      color: AppTheme.errorColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 120),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceLightColor,
                        borderRadius:
                            BorderRadius.circular(AppTheme.borderRadiusMedium),
                        border: Border.all(
                          color: AppTheme.surfaceDarkColor,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Écrivez votre message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(AppTheme.spacingUnit * 2),
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        onSubmitted: viewModel.isLoading ? null : _sendMessage,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingUnit * 2),
                  if (viewModel.isLoading)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  else
                    IconButton.filled(
                      icon: const Icon(Icons.send),
                      onPressed: () => _sendMessage(_messageController.text),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;
    
    final viewModel = context.read<MistralViewModel>();
    viewModel.sendMessage(message);
    _messageController.clear();
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingUnit * 2),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser)
            Padding(
              padding: const EdgeInsets.only(right: AppTheme.spacingUnit),
              child: CircleAvatar(
                backgroundColor: AppTheme.primaryColor,
                radius: 16,
                child: const Icon(
                  Icons.smart_toy,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                color: message.isUser
                    ? AppTheme.primaryColor
                    : AppTheme.cardColor,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowColor,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingUnit * 2,
                vertical: AppTheme.spacingUnit * 1.5,
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: message.isUser
                      ? AppTheme.textOnPrimaryColor
                      : AppTheme.textPrimaryColor,
                  height: 1.5,
                ),
              ),
            ),
          ),
          if (message.isUser)
            Padding(
              padding: const EdgeInsets.only(left: AppTheme.spacingUnit),
              child: CircleAvatar(
                backgroundColor: AppTheme.surfaceDarkColor,
                radius: 16,
                child: const Icon(
                  Icons.person,
                  size: 20,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
} 