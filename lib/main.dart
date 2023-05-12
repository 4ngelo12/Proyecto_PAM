import 'package:flutter/material.dart';
import 'package:proyecto/theme/theme_constants.dart';
import 'package:proyecto/screens/screens.dart';
import 'package:proyecto/theme/theme_managment.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isMaterial = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: isMaterial
          ? LoginApp(
          savedThemeMode: widget.savedThemeMode,
          onChanged: () => setState(() => isMaterial = false))
          : HomeApp(
          savedThemeMode: widget.savedThemeMode,
          onChanged: () => setState(() => isMaterial = true)),
    );
  }
}

/*
@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Calzados Kevin',
    initialRoute: 'login',
    routes: {
      'login':( _ )=>LoginScreen(),
      'home':( _ )=>HomeScreen(),
    },
    theme: lighTheme,
    darkTheme: darkTheme,
    themeMode: ThemeManager().getThemeMode,
  );
}
*/