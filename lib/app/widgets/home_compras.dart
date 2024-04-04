import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto/app/screens/formpago_screen.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/widgets/widgets.dart';
import '../models/datastatus.dart';
import '../services/carritocompras_service.dart';

class BuyApp extends StatefulWidget {
  const BuyApp({super.key});

  @override
  ComprasScreenS createState() => ComprasScreenS();
}

class ComprasScreenS extends State<BuyApp> {
  double? _total;
  double _totalPrice = 0;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cargar el resultado al ingresar
    _loadData();
  }

  Future<void> _loadData() async {
    // Obtener el resultado del Future<bool>
    _total = await total(_user!.uid);

    // Actualizar el estado con el resultado
    setState(() {
      _totalPrice = _total!;
    });
  }

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
      body: FutureBuilder(
        future: getShoppingCart(_user!.uid),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            if (dataStatus == DataStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (dataStatus == DataStatus.loaded) {
              return snapshot.data!.isNotEmpty ?
              CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                              (context, index) {

                            return Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Image.network(
                                          "${snapshot.data![index]['img']}",
                                          height: 140,
                                          width: 150,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        height: 140,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      "${snapshot.data![index]['nombre']}",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),

                                                  ),
                                                  Text(
                                                    "S/${snapshot.data![index]['precio']}",
                                                    style: const TextStyle(
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    child: Text(
                                                      "Talla: ${snapshot.data![index]['talla']}",
                                                      style: const TextStyle(
                                                          fontSize: 16
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Cantidad: ${snapshot.data![index]['cantidad']}",
                                                    style: const TextStyle(
                                                        fontSize: 16
                                                    ),
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    await deleteElementShoppingCart(_user!.uid, snapshot.data![index]['id'],
                                                        snapshot.data![index]['idProd'], snapshot.data![index]['idTalla'],
                                                        snapshot.data![index]['cantidad']);
                                                    _loadData();
                                                    _reloadData();
                                                  },
                                                  icon: const Icon(Icons.delete_forever)
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: snapshot.data!.length
                      )
                  )
                ],
              ) :
              const Clean(text: "No tienes productos en el carrito", icon: FontAwesomeIcons.boxOpen);
            } else if (dataStatus == DataStatus.error) {
              return const Text('Error al cargar los datos');
            } else {
              return snapshot.data!.isNotEmpty ?
              CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Image.network(
                                          "${snapshot.data![index]['img']}",
                                          height: 145,
                                          width: 150,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        height: 145,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      "${snapshot.data![index]['nombre']}",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data![index]['precio']}",
                                                    style: const TextStyle(
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    child: Text(
                                                      "Talla: ${snapshot.data![index]['talla']}",
                                                      style: const TextStyle(
                                                          fontSize: 16
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Cantidad: ${snapshot.data![index]['cantidad']}",
                                                    style: const TextStyle(
                                                        fontSize: 16
                                                    ),
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    await deleteElementShoppingCart(_user!.uid, snapshot.data![index]['id'],
                                                        snapshot.data![index]['idProd'], snapshot.data![index]['idTalla'],
                                                        snapshot.data![index]['cantidad']);
                                                    _loadData();
                                                    _reloadData();
                                                  },
                                                  icon: const Icon(Icons.delete_forever)
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: snapshot.data!.length
                      )
                  )
                ],
              ) :
              const Clean(text: "No tienes productos en el carrito", icon: FontAwesomeIcons.boxOpen);
            }
          } else {
            return const Center();
          }
        }),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Total: $_totalPrice",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: TextButton(
              onPressed: () {
                if (_totalPrice > 0) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          PagoSreen(total: _totalPrice)));
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                backgroundColor: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25)
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child:  Row(
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
              ),
            ),
          )
        ],
      )
    );
  }
}