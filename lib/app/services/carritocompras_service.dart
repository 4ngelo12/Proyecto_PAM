import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto/app/services/services.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

Future<void> addShoppingCart(String idU, String idProd, String name, double price, int cant, int size, String img, int total) async {
  /*await _db.collection('clientes').doc(idU).
  collection('carrito_compras').add({}).then((DocumentReference doc) async{
    await _db.collection('clientes').doc(idU).
    collection('carrito_compras').doc(doc.id).set({
      'id': doc.id,
      'idProd': idProd,
      'nombre': name,
      'precio': price,
      'talla': size,
      'cantidad': cant,
      'img': img,
    });
  });*/
  final tallas = await _db.collection('productos').doc(idProd).collection('talla').get();
  List lstTallaId = [];

  for (var e in tallas.docs) {
    final carrito = {
      'fid': e.id
    };
    print(carrito);

    lstTallaId.add(carrito.values);
  }


  await getTallas(idProd).then((value){
    for (var i in value) {
      if (i['cantidad'] == total)  {
        int nuevoT = total - cant;

      }
    }
  });
}

Future<List> getShoppingCart(String idU) async{
  final List lstShoppingCart = [];
  final docShoppingCart = await _db.collection('clientes').doc(idU).
  collection('carrito_compras').get();

  for (var element in docShoppingCart.docs) {
    lstShoppingCart.add(element);
  }

  return lstShoppingCart;
}

Future<void> deleteElementShoppingCart(String idU, String idES) async{
  final List lstShoppingCart = [];

  final docCli = await _db.collection('clientes').doc(idU).
  collection('carrito_compras').get();

  for (var e in docCli.docs) {
    final Map<String, dynamic> data = e.data();
    final carrito = {
      'id': data['id'],
      'fid': e.id
    };
    lstShoppingCart.add(carrito);
  }

  for (var element in lstShoppingCart) {
      if (element['id'] == idES) {
        await _db.collection('clientes').doc(idU).
      collection('carrito_compras').doc(element['fid']).delete();
      }
  }
}

Future<double> total(String idU) async {
  double total = 0;

  return getShoppingCart(idU).then((value) {
    for (var element in value){
      total += element['precio'];
    }
    return total;
  });
}