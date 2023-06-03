import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto/app/theme/theme_constants.dart';
import 'package:proyecto/app/theme/theme_colors.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:proyecto/app/services/firebase_service.dart';

class BuyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;
  final String idProd;

  const BuyApp({
    super.key,
    this.savedThemeMode,
    required this.onChanged,
    required this.idProd
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
        home: BuyScreen(onChanged: onChanged, idProd: idProd),
      ),
    );
  }
}

class BuyScreen extends StatefulWidget {
  final VoidCallback onChanged;
  final String idProd;

  const BuyScreen({super.key, required this.onChanged, required this.idProd});

  @override
  _BuyScreen createState() => _BuyScreen();
}

class _BuyScreen extends State<BuyScreen> {
  int? _numCantidad = 0; //Cantidad de elementos en la base de datos
  int _cantidad = 1; //Productos
  int _total = 0; //Unidades disponibles

  List<bool> isSelected = []; // Lista de estados de selección
  List<Color> buttonColors = []; // Lista de colores de los botones

  rellenar(int cant) {
    setState(() {
      isSelected = List.generate(cant, (index) => false);
      buttonColors = List.generate(cant, (index) => AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue);
    });
  }

  void selectButton(int index) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = (i == index); // Establece el estado de selección del botón actual
        buttonColors[i] = (i == index) ?
          AdaptiveTheme.of(context).mode.isDark ? General.generalSelectedDark : General.generalSelected :
          AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue; // Cambia el color del botón actual
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      HomeApp(onChanged: widget.onChanged, pocision: 0)));
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 30,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {

                              });
                            },
                            child: const Icon(
                              CupertinoIcons.heart,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              FutureBuilder(
                                  future: getProductoId(widget.idProd),
                                  builder: ((context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Image.asset(
                                        "${snapshot.data?[0]['imagen']}",
                                        height: 350,
                                        width: 350,
                                        fit: BoxFit.contain,
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  })
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 25)),
                        Container(
                          height: MediaQuery.of(context).size.height *  0.6,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 30,
                              horizontal: 20
                          ),
                          decoration: BoxDecoration(
                            color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                  future: getProductoId(widget.idProd),
                                  builder: ((context, snapshot) {
                                    if (snapshot.hasData) {
                                      //Datos del productos
                                      return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${snapshot.data?[0]['nombre']}",
                                                  style: const TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "S/${snapshot.data?[0]['precio']}",
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                                            Text(
                                              "${snapshot.data?[0]['descripcion']}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ],
                                        );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  })
                              ),
                              Row(
                                children: const [
                                   Padding(
                                     padding: EdgeInsets.symmetric(vertical: 10),
                                     child: Text(
                                       "Tallas:",
                                       style: TextStyle(
                                           fontSize: 18
                                       ),
                                       textAlign: TextAlign.start,
                                     ),
                                   )
                                ],
                              ),
                              //Tallas y cantidad
                              FutureBuilder(
                                  future: getTallas(widget.idProd),
                                  builder: ((context, snapshot) {
                                    if (snapshot.hasData) {
                                      return GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 55,
                                              mainAxisExtent: 35,
                                              crossAxisSpacing: 15
                                          ),
                                          itemCount: snapshot.data?.length,
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return TextButton(
                                                style: TextButton.styleFrom(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 15
                                                    ),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                  backgroundColor: buttonColors.isNotEmpty ? buttonColors[index] : AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                                ),
                                                onPressed:() {
                                                  setState(() {
                                                    _total = snapshot.data![index]['cantidad'];
                                                    _numCantidad = snapshot.data?.length;
                                                    rellenar(_numCantidad!);
                                                    if (isSelected.isNotEmpty) {
                                                      selectButton(index);
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  "${snapshot.data![index]['talla']}",
                                                  style: TextStyle(
                                                    color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )
                                            );
                                          });
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  })
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 25, right: 5),
                                    child: Text(
                                      "Cantidad:",
                                      style: TextStyle(
                                          fontSize: 18
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_cantidad > 1) {
                                                    _cantidad--;
                                                  }
                                                });
                                              },
                                              icon: Icon(FontAwesomeIcons.squareMinus)
                                          ),
                                          Text("$_cantidad"),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_cantidad > _total){
                                                    _cantidad = _total;
                                                  } else {
                                                    if (_cantidad < _total) {
                                                      _cantidad++;
                                                    }
                                                  }
                                                });
                                              },
                                              icon: Icon(FontAwesomeIcons.squarePlus)
                                          )
                                        ],
                                      ),
                                    ),
                                    //Text("${_cantidad}")
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Text(
                                        "Unidades disponibles: ${_total}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                        ),
                                      )
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                ),
                child: Row(
                  children: const [
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