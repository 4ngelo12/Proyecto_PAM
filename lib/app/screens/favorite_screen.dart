import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/services/services.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/screens/screens.dart';

class FavoriteApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const FavoriteApp({
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
        home: FavoriteScreen(onChanged: onChanged),
      ),
    );
  }
}

class FavoriteScreen extends StatefulWidget {
  final VoidCallback onChanged;

  const FavoriteScreen({super.key, required this.onChanged});

  @override
  _FavoriteScreen createState() => _FavoriteScreen();
}

class _FavoriteScreen extends State<FavoriteScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeApp(onChanged: widget.onChanged)));
            },
            icon: const Icon(Icons.arrow_back_ios_new)
        )
      ),
      body: FutureBuilder(
          future: getFavortiosId(user!.uid),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                        padding: EdgeInsets.all(50),
                        child: Center(
                          child: Text(
                            "Articulos Guardados",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    ),
                  ),
                  SliverList(delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return FutureBuilder(
                            future: getProductoId(snapshot.data?[index]),
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                            ),
                                            width: 140,
                                            child: Image.network(
                                              "${snapshot.data?[0]['imagen']}",
                                              height: 100,
                                              width: 100,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) =>
                                                    BuySApp(onChanged: widget.onChanged, idProd: snapshot.data?[0]['idProd'])));
                                          },
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 10, top: 5),
                                              child: Text(
                                                "${snapshot.data?[0]['nombre']}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 25
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 5),
                                              child: Text(
                                                "S/${snapshot.data?[0]['precio']}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 18
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 2,
                                              child:
                                              Text(
                                                "${snapshot.data?[0]['descripcion']}",
                                                textAlign: TextAlign.start,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  deleteFavoriteProduct(snapshot.data?[0]['idProd'], user!.uid);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FavoriteApp(onChanged: widget.onChanged)));
                                                },
                                                child: Text("Eliminar"))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })
                        );
                      },
                      childCount: snapshot.data?.length
                  )
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })
      ),
    );
  }
}