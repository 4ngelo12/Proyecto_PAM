import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/app/screens/screens.dart';
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
  final fbinstance = FirebaseAuth.instance;

  Widget _estadoSesion() {
    if (fbinstance.currentUser != null){
      isMaterial = false;
    } else {
      isMaterial = true;
    }

    return isMaterial
        ?
    LoginApp(
        savedThemeMode: widget.savedThemeMode,
        onChanged: () => setState(() => isMaterial = true)) :
    HomeApp(
      savedThemeMode: widget.savedThemeMode,
      onChanged: () => setState(() => isMaterial = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: _estadoSesion(),
    );
  }
}