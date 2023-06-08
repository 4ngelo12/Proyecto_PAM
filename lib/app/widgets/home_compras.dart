import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/services/firebase_service.dart';
import 'package:proyecto/app/theme/themes.dart';

class BuyApp extends StatefulWidget {
  final VoidCallback onChanged;

  const BuyApp({super.key, required this.onChanged});

  @override
  _ComprasScreen createState() => _ComprasScreen();
}

class _ComprasScreen extends State<BuyApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                      ),
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/calzadoskevin-83642.appspot.com/o/productos%2F1.png?alt=media&token=3bf8353e-fc79-4b3c-9362-3acaa9076228',
                        width: 140,
                        height: 100,
                      ),
                    ),
                    Row(
                      children: const [
                        Padding(padding: EdgeInsets.all(20), child: Text("Titulo", style: TextStyle(fontSize: 20))),
                        Text("Precio", style: TextStyle(fontSize: 20)),
                      ],
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Realizar el Pago",
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
            Icon(
              CupertinoIcons.cart_badge_plus,
              size: 22,
            )
          ],
        ),
      )
    );

  }
}