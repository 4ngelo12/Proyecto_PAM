import 'package:flutter/material.dart';
import 'package:proyecto/screens/screens.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        child:  isMaterial
            ?  LoginApp(
            savedThemeMode: widget.savedThemeMode,
            onChanged: () => setState(() => isMaterial = false))
            : HomeApp(
            savedThemeMode: widget.savedThemeMode,
            onChanged: () => setState(() => isMaterial = false)
        ),
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