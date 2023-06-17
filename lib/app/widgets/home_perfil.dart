import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:proyecto/app/services/cliente_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto/main.dart';

class ProfileApp extends StatefulWidget {
  const ProfileApp({super.key});

  @override
  ProfScreen createState() => ProfScreen();
}

class ProfScreen extends State<ProfileApp> {
  final _auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final String? idUser = _auth?.uid;

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
                  FutureBuilder(
                      future: getClientesId(idUser!),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Bienvenido/a",
                                style: TextStyle(
                                    fontSize: 28
                                ),
                              ),
                              Text(
                                '${snapshot.data?[0]['nombre']} ${snapshot.data?[0]['apellido']}',
                                style: const TextStyle(
                                    fontSize: 18
                                ),
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })
                  )
                ],
              ),
            )
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 35)),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child:  Row(
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
                          const EditUserScreen()));
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FavoriteScreen()));
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              InkWell(
                child:  Row(
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const MisComprasScreen()));
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              InkWell(
                child:  Row(
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ContactScreen()));
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              InkWell (
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyApp()));
                },
                child:  Row(
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