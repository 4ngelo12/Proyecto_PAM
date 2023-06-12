import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/widgets/widgets.dart';

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
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inicio',
        theme: theme,
        darkTheme: darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late Icon iconTheme;
  late Widget contenido = const ProductApp();
  int _selectedItem = 0;

  Icon _themeIcon(newValue) {
      if (newValue) {
        iconTheme = const Icon(Icons.light_mode);
      } else {
        iconTheme = const Icon(Icons.dark_mode);
      }
    return iconTheme;
  }

  void _itemUsado(int index) {
    setState(() {
      _selectedItem = index;
      switch(index) {
        case 0:
          contenido = const ProductApp();
          break;
        case 1:
          contenido = const BuyApp();
          break;
        case 2:
          contenido = const ProfileApp();
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      iconTheme = const Icon(Icons.light_mode);
                    } else {
                      AdaptiveTheme.of(context).setLight();
                      iconTheme = const Icon(Icons.dark_mode);
                    }
                  });
                },
                icon: _themeIcon(AdaptiveTheme.of(context).mode.isDark)),
            const Padding(padding:EdgeInsets.all(10)),
            Image.asset(
                "Assets/Images/logo.png",
                width: 130
            ),
          ],
        )
      ),
      body: contenido,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AdaptiveTheme.of(context).mode.isDark ? BottomBottomNavigationBarColor.labelDark : BottomBottomNavigationBarColor.label,
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.house,
              color: Colors.white,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: "Mis Compras",

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle,
              color: Colors.white,
            ),
            label: "Perfil",
          ),
        ],
        currentIndex: _selectedItem,
        onTap: _itemUsado,

      ),
    );
  }
}