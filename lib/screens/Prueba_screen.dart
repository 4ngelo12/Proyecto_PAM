import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/theme/theme_constants.dart';

class PruebaApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const PruebaApp({
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
        home: PruebaScreen(),
      ),
    );
  }
}

class PruebaScreen extends StatefulWidget {

  const PruebaScreen({super.key});

  @override
  _PruebaScreen createState() => _PruebaScreen();
}

class _PruebaScreen extends State<PruebaScreen> {
  late Icon iconTheme;

  Icon ThemeIcon(newValue) {
    if (newValue) {
      iconTheme = Icon(Icons.dark_mode);
    } else {
      iconTheme = Icon(Icons.light_mode);
    }
    return iconTheme;
  }


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


