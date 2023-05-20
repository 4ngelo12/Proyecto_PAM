import 'package:flutter/material.dart';
import 'package:proyecto/screens/screens.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/services/firebase_service.dart';
import 'package:proyecto/theme/theme_colors.dart';

class Perfil extends StatefulWidget {
  final VoidCallback onChanged;

  const Perfil({super.key, required this.onChanged});

  @override
  _PerfilScreen createState() => _PerfilScreen();
}

class _PerfilScreen extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Perfil del usuario"),
    );
  }

}