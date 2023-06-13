import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/theme/themes.dart';

class Clean extends StatelessWidget {
  final String text;
  final IconData icon;

  const Clean({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 120,
              color: AdaptiveTheme.of(context).mode.isDark ? NoData.noDataBackGDark : NoData.noDataBackG,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                  text,
                  style: TextStyle(
                      color: AdaptiveTheme.of(context).mode.isDark ? NoData.noDataBackGDark : NoData.noDataBackG,
                      fontSize: 20
                  )
              ),
            )
          ],
        )
    );
  }
}