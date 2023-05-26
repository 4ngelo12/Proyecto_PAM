import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:proyecto/app/services/cliente_service.dart';
import 'package:proyecto/app/theme/theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Perfil extends StatefulWidget {
  final VoidCallback onChanged;

  const Perfil({super.key, required this.onChanged});

  @override
  _PerfilScreen createState() => _PerfilScreen();
}

class _PerfilScreen extends State<Perfil> {
  final fbinstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final String? idUser = auth.currentUser?.uid;
    return Column (
        children: [
          Container(color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    CupertinoIcons.person_crop_circle,
                    size: 200,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Bienvenido/a",
                        style: TextStyle(
                          fontSize: 28
                        ),
                      ),
                      Text(
                        "Angelo Casapaico",
                        style: TextStyle(
                            fontSize: 18
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 35)),
          Container(
            width: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Row(
                    children: const [
                      Padding(padding: EdgeInsets.only(left: 65)),
                      Icon(
                        FontAwesomeIcons.penToSquare,
                        size: 30,
                      ),
                      Padding(padding: EdgeInsets.only(left: 25)),
                      Text(
                        "Editar Datos",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            EditUserApp(onChanged: widget.onChanged)));

                    fbinstance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user == null) {
                        print('User is currently signed out!');
                      } else {
                        print('User is signed in!');
                      }
                    });
                    fbinstance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user != null) {
                        print(user.uid);
                        getClientesId(idUser!);
                      }
                    });

                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                InkWell(
                  child: Row(
                    children: const [
                      Padding(padding: EdgeInsets.only(left: 65)),
                      Icon(
                        Icons.favorite,
                        size: 30,
                      ),
                      Padding(padding: EdgeInsets.only(left: 25)),
                      Text(
                        "Favoritos",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                  onTap: () {},
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                InkWell(
                  child: Row(
                    children: const [
                      Padding(padding: EdgeInsets.only(left: 65)),
                      Icon(
                        Icons.list_alt,
                        size: 30,
                      ),
                      Padding(padding: EdgeInsets.only(left: 25)),
                      Text(
                        "Mis Compras",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                  onTap: () {},
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                InkWell(
                  child: Row(
                    children: const [
                      Padding(padding: EdgeInsets.only(left: 65)),
                      Icon(
                        Icons.contact_support_outlined,
                        size: 30,
                      ),
                      Padding(padding: EdgeInsets.only(left: 25)),
                      Text(
                        "Contacto",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                  onTap: () {},
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                InkWell (
                  onTap: () async{
                    await FirebaseAuth.instance.signOut();
                    fbinstance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user == null) {
                        print('User is currently signed out!');
                      } else {
                        print('User is signed in!');
                      }
                    });
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginApp(onChanged: widget
                                    .onChanged)));
                  },
                  child: Row(
                    children: const [
                      Padding(padding: EdgeInsets.only(left: 65)),
                      Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        size: 30,
                      ),
                      Padding(padding: EdgeInsets.only(left: 25)),
                      Text(
                        "Cerrar Sesión",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
  }

}