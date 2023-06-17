import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/services/services.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:proyecto/app/widgets/widgets.dart';
import '../models/datastatus.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenS createState() => _FavoriteScreenS();
}

class _FavoriteScreenS extends State<FavoriteScreen> {
  final _user = FirebaseAuth.instance.currentUser;

  void _reloadData() {
    setState(() {
      dataStatus = DataStatus.loading;
    });

    getShoppingCart(_user!.uid).then((data) {
      setState(() {
        dataStatus = DataStatus.loaded;
      });
    }).catchError((error) {
      setState(() {
        dataStatus = DataStatus.error;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: IconButton(
              onPressed: () {
                Navigator.pop(context);
                },
              icon: const Icon(Icons.arrow_back_ios_new)
          )
      ),
      body: FutureBuilder(
          future: getFavortiosId(_user!.uid),
          builder: ((context, snapshot) {
            if (dataStatus == DataStatus.loading) {
              return const CircularProgressIndicator();
            } else if (dataStatus == DataStatus.loaded) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty ?
                CustomScrollView(
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
                                                      BuyScreen(idProd: snapshot.data?[0]['idProd'])));
                                            },
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10, top: 5),
                                                child: Text(
                                                  "${snapshot.data?[0]['nombre']}",
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 25
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 5),
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
                                                    deleteFavoriteProduct(snapshot.data?[0]['idProd'], _user!.uid);
                                                    _reloadData();
                                                  },
                                                  child: const Text("Eliminar"))
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
                ) :
                const Clean(text: "No tienes productos favoritos", icon: CupertinoIcons.heart_slash_circle_fill);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else if (dataStatus == DataStatus.error) {
              return const Text('Error al cargar los datos');
            } else {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty ?
                CustomScrollView(
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
                                                      BuyScreen(idProd: snapshot.data?[0]['idProd'])));
                                            },
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10, top: 5),
                                                child: Text(
                                                  "${snapshot.data?[0]['nombre']}",
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 25
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 5),
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
                                                    deleteFavoriteProduct(snapshot.data?[0]['idProd'], _user!.uid);
                                                    _reloadData();
                                                  },
                                                  child: const Text("Eliminar"))
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
                ) :
                const Clean(text: "Aún no tienes productos favoritos", icon: CupertinoIcons.heart_slash_circle_fill);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          })
      ),
    );
  }
}