import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/widgets/widgets.dart';

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
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inicio',
        theme: theme,
        darkTheme: darkTheme,
        home: HomeScreen(onChanged: onChanged),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onChanged;

  const HomeScreen({super.key, required this.onChanged});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late Icon iconTheme;
  int _elementoSeleccionado = 0;
  late Widget contenido = Inicio(onChanged: widget.onChanged);

  Icon _themeIcon(newValue) {
      if (newValue) {
        iconTheme = const Icon(Icons.dark_mode);
      } else {
        iconTheme = const Icon(Icons.light_mode);
      }
    return iconTheme;
  }

  void _itemUsado(int index) {
    setState(() {
      _elementoSeleccionado = index;
      switch(_elementoSeleccionado) {
        case 0:
          contenido = Inicio(onChanged: widget.onChanged);
          break;
        case 1:
          contenido = Compras(onChanged: widget.onChanged);
          break;
        case 2:
          contenido = Perfil(onChanged: widget.onChanged);
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
            Row(
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
                          iconTheme = const Icon(Icons.dark_mode);
                        } else {
                          AdaptiveTheme.of(context).setLight();
                          iconTheme = const Icon(Icons.light_mode);
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
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search)
            )
          ],
        ),
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
        currentIndex: _elementoSeleccionado,
        onTap: _itemUsado,
      ),
    );
  }
}