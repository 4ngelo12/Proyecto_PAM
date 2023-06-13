import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/app/services/ventas_service.dart';
import '../theme/themes.dart';

class MisComprasScreen extends StatefulWidget {
  const MisComprasScreen({super.key});

  @override
  _MisComprasScreen createState() => _MisComprasScreen();
}

class _MisComprasScreen extends State<MisComprasScreen> {
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getDetVenta(_user!.uid),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: IconButton(
                  onPressed: ()  {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
              ),
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${snapshot.data![index]['nombre']}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold
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
          );
        }),
      ),
    );
  }

}