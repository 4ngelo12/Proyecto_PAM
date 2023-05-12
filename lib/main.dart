import 'package:flutter/material.dart';
import 'package:proyecto/theme/theme_constants.dart';
import 'package:proyecto/screens/screens.dart';
import 'package:proyecto/theme/theme_managment.dart';

void main() =>runApp(MyApp());

ThemeManager _themeManager = ThemeManager();

class  MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'login':( _ )=>LoginScreen(),
        'home':( _ )=>HomeScreen(),
      },
      theme: AppTheme.lighTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeManager.getThemeMode,
    );
  }
}
