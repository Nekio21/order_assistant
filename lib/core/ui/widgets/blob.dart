import 'package:flutter/cupertino.dart';
import 'package:order_assistant/core/ui/theme/app_spacing.dart';
import 'package:order_assistant/core/ui/theme/app_text_style.dart';
import 'package:order_assistant/core/ui/theme/app_theme.dart';

class Blob extends StatelessWidget{
  final String text;

  const Blob({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.small),
      decoration: const BoxDecoration(
        color: AppTheme.accent,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        text,
        style: AppTextStyle.captionBold.copyWith(color: AppTheme.onAccent, fontSize: 14),
      ),
    );
  }
}