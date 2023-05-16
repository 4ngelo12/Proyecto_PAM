import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/theme/theme_constants.dart';
import 'package:proyecto/theme/theme_colors.dart';

class BuyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const BuyApp({
    super.key,
    this.savedThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Comprar',
        theme: theme,
        darkTheme: darkTheme,
        home: BuyScreen(),
      ),
    );
  }
}

class BuyScreen extends StatefulWidget {

  BuyScreen({super.key});

  @override
  _BuyScreen createState() => _BuyScreen();
}

class _BuyScreen extends State<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Hola"),
    );
  }

}