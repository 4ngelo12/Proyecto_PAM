import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

Future<void> addShoppingCart(String idU, String name, double price, int cant, int size, String img) async {
  await _db.collection('clientes').doc(idU).
  collection('carrito_compras').add({}).then((DocumentReference doc) async{
    await _db.collection('clientes').doc(idU).
    collection('carrito_compras').doc(doc.id).set({
      'id': doc.id,
      'nombre': name,
      'precio': price,
      'talla': size,
      'cantidad': cant,
      'img': img,
    });
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

Future<void> deleteElementShoppingCart(String idU) async{
  final List lstShoppingCart = [];
  String? ele;

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
  ele = lstShoppingCart.asMap()[0]['fid'].toString();

  for (var element in lstShoppingCart) {
    if (element['id'] == ele) {
      await _db.collection('clientes').doc(idU).
      collection('carrito_compras').doc(element['fid']).delete();
    }
  }
}