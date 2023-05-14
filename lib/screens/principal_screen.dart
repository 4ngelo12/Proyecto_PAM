import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/screens/screens.dart';
import 'package:proyecto/theme/theme_constants.dart';

class HomeApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const HomeApp({
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
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {

  HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
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
            IconButton(
                onPressed: () {
                  AdaptiveTheme.of(context).setTheme(
                      light: AppTheme.lightTheme,
                      dark: AppTheme.darkTheme
                  );
                  setState(() {
                    if (AdaptiveTheme.of(context).mode.isLight) {
                      AdaptiveTheme.of(context).setDark();
                      iconTheme = Icon(Icons.light_mode);
                    } else {
                      AdaptiveTheme.of(context).setLight();
                      iconTheme = Icon(Icons.dark_mode);
                    }
                  });
                },
                icon: ThemeIcon(AdaptiveTheme.of(context).mode.isLight)),
            Padding(padding: EdgeInsets.all(10)),
            Image.asset(
                "Assets/Images/logo.png",
                width: 135
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        ],
      ),
    );
  }

}


