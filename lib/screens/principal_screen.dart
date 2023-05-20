import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/screens/screens.dart';
import 'package:proyecto/services/firebase_service.dart';
import 'package:proyecto/theme/theme_colors.dart';
import 'package:proyecto/theme/theme_constants.dart';
import 'package:proyecto/clases/zapatillas.dart';

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
  String texto_a_visualizar = "0: home";
  final datos = calzados;


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
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 25
          ),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
          ),
          child: Image.asset(urlImage, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20),
          child: Column(
            children: [
              Text(
                datos[index].nombre,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
              const Padding(padding: EdgeInsets.only(
                  bottom: 15,
                  left: 150)
              ),
              Row(
                children: [
                  Text(datos[index].precio.toString()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 1
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BuyApp(onChanged: widget.onChanged)));
                        },
                        icon: const Icon(
                            Icons.shopping_cart,
                            size: 15
                        ),
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
                          iconTheme = const Icon(Icons.light_mode);
                        } else {
                          AdaptiveTheme.of(context).setLight();
                          iconTheme = const Icon(Icons.dark_mode);
                        }
                      });
                    },
                    icon: _themeIcon(AdaptiveTheme.of(context).mode.isLight)),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: getProductos(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return CarouselSlider.builder(
                      options: CarouselOptions(
                          height: 150,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4)
                      ),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = "${snapshot.data?[index]['imagen']}";

                        return buildImage(urlImage, index);
                      },
                    );
                  } else {
                    return const Center();
                  }
                })
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            FutureBuilder(
                future: getProductos(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 350,
                            crossAxisSpacing: 2
                        ),
                        itemCount: snapshot.data?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(
                                left: 25,
                                right: 25,
                                top: 10
                            ),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => BuyApp(onChanged: widget.onChanged)));
                                    },
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10) ,
                                      child: Image.asset("${snapshot.data?[index]['imagen']}"),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data?[index]['nombre'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "New Nike Shoes for men",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'S/.${snapshot.data?[index]['precio']}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child:
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => BuyApp(onChanged: widget.onChanged)));
                                            },
                                            icon: Icon(
                                              CupertinoIcons.cart_fill_badge_plus,
                                              size: 25,
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            ),
          ],
        ),
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




