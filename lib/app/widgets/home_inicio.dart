import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/services/producto_service.dart';
import 'package:proyecto/app/theme/themes.dart';

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});

  @override
  _ProductScreen createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductApp> {
  TextEditingController controllerSearch = TextEditingController();

  Widget buildImage(String urlImage, int index) {
    return FutureBuilder(
        future: getProductos(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Container(
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
                    child: Image.network(urlImage,
                      height: 60,
                      width: 90),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Column(
                      children: [
                        Text(
                          snapshot.data?[index]['nombre'],
                          style: const TextStyle(
                              fontSize: 20
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(
                            bottom: 15,
                            left: 150)
                        ),
                        Row(
                          children: [
                            Text(
                              'S/.${snapshot.data?[index]['precio']}',
                              style: const TextStyle(
                                fontSize: 16
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>
                                            BuySApp(idProd: snapshot.data?[index]['idProd'])));
                                  },
                                  icon: const Icon(
                                      Icons.shopping_cart,
                                      size: 20
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
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    itemCount: 4,
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
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controllerSearch,
              onChanged: (value) {
               setState(() {});
              },
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: const Icon(Icons.search),
                fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                filled: true,
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelStyle: TextStyle(
                    color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Prod(text: controllerSearch.text),
          )
        ],
      ),
    );
  }
}

class Prod extends StatelessWidget {
  final String text;

  const Prod({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProductos(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List? lstProds = snapshot.data;
            if (text.isNotEmpty) {
              String lowerText = text.toLowerCase();
              lstProds = lstProds?.where((element) => element['nombre'].toString().toLowerCase().contains(lowerText)).toList();
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 350,
                    crossAxisSpacing: 2
                ),
                itemCount: lstProds?.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10
                    ),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => BuySApp(idProd: lstProds![index]['idProd'])));
                            },
                            child:  Padding(
                              padding: const EdgeInsets.all(10) ,
                              child: Image.network("${lstProds![index]['imagen']}"),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              lstProds[index]['nombre'],
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
                                'S/.${lstProds[index]['precio']}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>
                                              BuySApp(idProd: lstProds![index]['idProd'])));
                                    },
                                    icon: const Icon(
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        })
    );
  }
  
}