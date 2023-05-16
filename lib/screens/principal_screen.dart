import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/screens/screens.dart';
import 'package:proyecto/theme/theme_colors.dart';
import 'package:proyecto/theme/theme_constants.dart';
import 'package:proyecto/clases/zapatillas.dart';

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
  int _elementoSeleccionado = 0;
  String texto_a_visualizar = "0: home";
  final datos = calzados;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  ];

  Icon ThemeIcon(newValue) {
      if (newValue) {
        iconTheme = Icon(Icons.dark_mode);
      } else {
        iconTheme = Icon(Icons.light_mode);
      }
    return iconTheme;
  }

  void _itemUsado(int index) {
    setState(() {
      _elementoSeleccionado = index;
      switch(_elementoSeleccionado) {
        case 0:
          texto_a_visualizar = "$_elementoSeleccionado: home";
          break;
        case 1:
          texto_a_visualizar = "$_elementoSeleccionado: Mis Compras";
          break;
        case 2:
          texto_a_visualizar = "$_elementoSeleccionado: Perfil";
          break;
      }
    });
  }

  Widget buildImage(String urlImage, int index) => Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
    ),
    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5
          ),
          child: Image.network(urlImage, fit: BoxFit.cover),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 15), 
          child: Column(
            children: [
              Text(
                datos[index].nombre,
                style: TextStyle(
                    fontSize: 16
                ),
              ), 
              Padding(padding: EdgeInsets.only(bottom: 10)), 
              Row(
                children: [
                  Text(datos[index].precio.toString()),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ), 
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5
                      ), 
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)), 
                        color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                      ), 
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BuyApp()));
                        },
                        icon: Icon(Icons.shopping_cart),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );

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
                    width: 130
                ),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.search)
            )
          ],
        ),

      ),
      body: Column(
            children: [
              CarouselSlider.builder(
                  options: CarouselOptions(
                      height: 150,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4)),
                  itemCount: imgList.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = imgList[index];

                    return buildImage(urlImage, index);
                  },
              ),

              SingleChildScrollView(
                child: Column(
                  children: [
                    Container()
                  ],
                ),
              )
            ]
      ),
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
