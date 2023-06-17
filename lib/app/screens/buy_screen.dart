import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto/app/services/services.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/widgets/widgets.dart';

class BuyScreen extends StatefulWidget {
  final String idProd;

  const BuyScreen({super.key, required this.idProd});

  @override
  _BuyScreen createState() => _BuyScreen();
}

class _BuyScreen extends State<BuyScreen> {
  final _user = FirebaseAuth.instance.currentUser;
  bool? _result;
  bool _liked = false;
  late Widget _favorite;

  String? idTalla;
  String? name;
  double? price;
  int? cant;
  int? size;
  String? img;

  int? _numCantidad = 0; //Cantidad de elementos en la base de datos
  int _cantidad = 0; //Productos
  int _total = 0; //Unidades disponibles

  List<bool> isSelected = []; // Lista de estados de selección
  List<Color> buttonColors = []; // Lista de colores de los botones

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cargar el resultado al ingresar
    _loadData();
  }

  Future<void> _loadData() async {
    // Obtener el resultado del Future<bool>
    bool result = await isFavorite(widget.idProd, _user!.uid);

    // Actualizar el estado con el resultado
    setState(() {
      _result = result;
      _liked = result;
    });
  }

  void _cambiarEstado() {
    setState(() {
      if (_liked) {
        _liked = false;
      }
      else {
        _liked = true;
      }
      _favorite = _liked ?  const Icon(Icons.favorite, color: Colors.red, size: 30) : const Icon(Icons.favorite_border, color: Colors.white, size: 30);
      _liked ? addFavoriteProduct(widget.idProd, _user!.uid) : deleteFavoriteProduct(widget.idProd, _user!.uid);
    });
  }

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
    _favorite = _result != null
        ? _liked ?  const Icon(Icons.favorite, color: Colors.red, size: 30) : const Icon(Icons.favorite_border, color: Colors.white, size: 30)
        : const CircularProgressIndicator();
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
                              Navigator.pop(context);
                              },
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 30,
                            ),
                          ),
                          IconButton(
                              onPressed: _cambiarEstado,
                              icon: _favorite
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
                                      return Image.network(
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
                          height: MediaQuery.of(context).size.height *  0.7,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 30,
                              horizontal: 15
                          ),
                          decoration: BoxDecoration(
                            color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Datos del productos
                              FutureBuilder(
                                  future: getProductoId(widget.idProd),
                                  builder: ((context, snapshot) {
                                    if (snapshot.hasData) {
                                      String valor = "${snapshot.data?[0]['precio']}";
                                      name = snapshot.data?[0]['nombre'];
                                      price = double.parse(valor.toString());
                                      img = snapshot.data?[0]['imagen'];

                                      return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 290,
                                                  child: Text(
                                                    "${snapshot.data![0]['nombre']}",
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                    overflow: TextOverflow.clip,
                                                  ),

                                                ),
                                                Text(
                                                  "S/${snapshot.data?[0]['precio']}",
                                                  style: const TextStyle(
                                                    fontSize: 20,
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
                                      cant = _cantidad;
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
                                                    idTalla = snapshot.data![index]['idTalla'];
                                                    _total = snapshot.data![index]['cantidad'];
                                                    _cantidad = 1;
                                                    _numCantidad = snapshot.data?.length;
                                                    rellenar(_numCantidad!);
                                                    if (isSelected.isNotEmpty) {
                                                      selectButton(index);
                                                      size = snapshot.data![index]['talla'];
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  "${snapshot.data![index]['talla']}",
                                                  style: TextStyle(
                                                    color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
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
                                    padding: const EdgeInsets.only(top: 25),
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
                                              icon: const Icon(FontAwesomeIcons.squareMinus)
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
                                              icon: const Icon(FontAwesomeIcons.squarePlus)
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        "Unidades disponibles: $_total",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                        ),
                                      )
                                  )
                                ],
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 60),
                                  color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                  child: TextButton(
                                    onPressed: () {
                                      if (size != null) {
                                        addShoppingCart(_user!.uid, widget.idProd, idTalla!, name!, (double.parse(price!.toString()) * cant!), cant!, size!, img!, _total);
                                        successfulMessage(context, "Producto Agregado en el carrito");
                                      } else {
                                        successfulMessage(context, "Seleciona una talla para agregar al carrito");
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Agregar al Carrito",
                                            style: TextStyle(
                                                fontSize: 18
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                          Icon(
                                            CupertinoIcons.cart_badge_plus,
                                            size: 22,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
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
    );
  }
}