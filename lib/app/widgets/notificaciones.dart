import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import '../theme/theme_colors.dart';

void mensaje(BuildContext context, String msg) {
  ElegantNotification.success(
      background: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
      title: const Text(
          "Operación Completada"
      ),
      description: Text(msg),
      toastDuration:const Duration(seconds: 8)).show(context);
}