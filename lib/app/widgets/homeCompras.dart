import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/services/firebase_service.dart';
import 'package:proyecto/app/theme/theme_colors.dart';

class Compras extends StatefulWidget {
  final VoidCallback onChanged;

  const Compras({super.key, required this.onChanged});

  @override
  _ComprasScreen createState() => _ComprasScreen();
}

class _ComprasScreen extends State<Compras> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

        ],
      ),
    );
  }
}