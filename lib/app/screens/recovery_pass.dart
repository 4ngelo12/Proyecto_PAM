import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/theme/theme_constants.dart';

class RecoveryApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const RecoveryApp({
    super.key,
    this.savedThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inicio',
        theme: theme,
        darkTheme: darkTheme,
        home: const RecoveryScreen(),
      ),
    );
  }
}

class RecoveryScreen extends StatefulWidget {

  const RecoveryScreen({super.key});

  @override
  _RecoveryScreen createState() => _RecoveryScreen();
}

class _RecoveryScreen extends State<RecoveryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Esti es una nueva pantalla"),
          ],
        ),
      ),
    );
  }

}


