import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppLoading extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const AppLoading({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [if (isLoading) CircularProgressIndicator(color: AppTheme.primary), child],
      ),
    );
  }
}
