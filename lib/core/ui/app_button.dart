import 'package:flutter/material.dart';
import 'package:order_assistant/core/ui/app_spacing.dart';
import 'package:order_assistant/core/ui/app_text_style.dart';
import 'package:order_assistant/core/ui/app_theme.dart';

class AppButton extends StatelessWidget {
  final bool _isActive;
  final IconData _icon;
  final String _text;
  final VoidCallback _onClick;

  const AppButton({
    super.key,
    required bool isActive,
    required IconData icon,
    required String text,
    required VoidCallback onClick,
  }) : _isActive = isActive,
       _icon = icon,
       _text = text,
       _onClick = onClick;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isActive ? AppTheme.accent : AppTheme.secondary;
    final color = _isActive ? AppTheme.onAccent : AppTheme.onSecondary;

    return GestureDetector(
      onTap: _onClick,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.small,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(_icon, size: 24, color: color),
            Text(_text, style: AppTextStyle.captionRegular.apply(color: color)),
          ],
        ),
      ),
    );
  }
}
