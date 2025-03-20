import 'package:flutter/material.dart';
import 'package:oto_app_ia/config/theme.dart';

class InfoTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final double maxWidth;

  const InfoTooltip({
    super.key,
    required this.message,
    required this.child,
    this.maxWidth = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      preferBelow: true,
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppTheme.dividerColor,
          width: 1,
        ),
      ),
      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppTheme.textPrimaryColor,
      ),
      waitDuration: const Duration(milliseconds: 500),
      showDuration: const Duration(seconds: 4),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          if (message.isNotEmpty) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.info_outline,
              size: 16,
              color: AppTheme.textTertiaryColor,
            ),
          ],
        ],
      ),
    );
  }
}

class HelpIcon extends StatelessWidget {
  final String message;
  final double size;

  const HelpIcon({
    super.key,
    required this.message,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InfoTooltip(
      message: message,
      child: Icon(
        Icons.help_outline,
        size: size,
        color: AppTheme.textTertiaryColor,
      ),
    );
  }
} 