import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/theme/theme_managment.dart';

ThemeManager _themeManager = ThemeManager();

class HomeApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const HomeApp({
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
        home: HomeScreen(onChanged: onChanged),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onChanged;

  HomeScreen({super.key, required this.onChanged});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  Icon iconTheme = Icon(Icons.dark_mode);

  cambiarModo(newValue) {
    setState(() {
      if (newValue) {
        iconTheme = Icon(Icons.dark_mode);
      } else {
        iconTheme = Icon(Icons.light_mode);
      }
    });
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if(mounted) {
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (AdaptiveTheme.of(context).mode.isLight) {
                      iconTheme = Icon(Icons.dark_mode);
                      AdaptiveTheme.of(context).setDark();
                    } else {
                      iconTheme = Icon(Icons.light_mode);
                      AdaptiveTheme.of(context).setLight();
                    }
                  });
                },
                icon: iconTheme),
            Padding(padding: EdgeInsets.all(10)),
            Image.asset(
                "Assets/Images/logo.png",
                width: 135
            ),
          ],
        ),
      ),
    );
  }

}


