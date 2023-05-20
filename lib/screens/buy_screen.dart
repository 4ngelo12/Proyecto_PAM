import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/theme/theme_constants.dart';
import 'package:proyecto/theme/theme_colors.dart';
import 'package:proyecto/screens/screens.dart';
import 'package:proyecto/clases/zapatillas.dart';

class BuyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const BuyApp({
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
        title: 'Comprar',
        theme: theme,
        darkTheme: darkTheme,
        home: BuyScreen(onChanged: onChanged),
      ),
    );
  }
}

class BuyScreen extends StatefulWidget {
  final VoidCallback onChanged;

  BuyScreen({super.key, required this.onChanged,});

  @override
  _BuyScreen createState() => _BuyScreen();
}

class _BuyScreen extends State<BuyScreen> {
  final datos = calzados;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                HomeApp(onChanged: widget.onChanged)));
                      },
                      child: Container(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                      },
                      child: Container(
                        child: Icon(
                          CupertinoIcons.heart,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.43,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "Assets/Images/4.png",
                      height: 350,
                      width: 350,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 25)),
              Container(
                height: MediaQuery.of(context).size.height *  0.45,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20
                ),
                decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          datos[0].nombre,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          datos[0].precio.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text(
                      datos[0].descripcion,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
              ),
              child: Row(
                children: [
                  Text(
                    "Agregar al Carrito",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Icon(
                    CupertinoIcons.cart_badge_plus,
                    size: 20,
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

}