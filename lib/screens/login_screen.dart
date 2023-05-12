import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class LoginApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const LoginApp({
    super.key,
    this.savedThemeMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: LoginScreen(onChanged: onChanged),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final VoidCallback onChanged;

  LoginScreen({super.key, required this.onChanged});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Este es el login"),
      ),
      body: Center(
        child: TextButton(
          onPressed: widget.onChanged,
          child: Text("Ir a Home"),
        ),
      ),
    );
  }

}


