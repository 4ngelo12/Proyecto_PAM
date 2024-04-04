import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto/app/models/compras/carrito_model.dart';
import 'package:proyecto/app/services/services.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

Future<void> addShoppingCart(String idU, String idProd, String idTalla, String name, double price, int cant, int size, String img, int total)
async {
  ShoppingCartModel data = ShoppingCartModel(id: "",
      idProd: idProd, idTalla: idTalla, nombre: name, precio: price, talla: size, cantidad: cant, img: img);

  await _db.collection('clientes').doc(idU).
  collection('carrito_compras').add({}).then((DocumentReference doc) async{
    await _db.collection('clientes').doc(idU).
    collection('carrito_compras').doc(doc.id)
        .set(ShoppingCartModel(id: doc.id, idProd: idProd, idTalla: idTalla, nombre: name, precio: price,
        talla: size, cantidad: cant, img: img).toJson());
  });

  int nuevoT = 0;

  await getTallas(idProd).then((value) async{
    for (var i in value) {
      if (i['idTalla'] == idTalla) {
        nuevoT = total - cant;
        await _db.collection('productos').doc(idProd).collection('talla').doc(i['idTalla']).update({
          'cantidad': nuevoT,
          'idTalla': i['idTalla'],
          'talla': i['talla']
        });
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

Future<void> deleteElementShoppingCart(String idU, String idES, String idProd, String idTalla, int cant) async{
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

        int nuevoT = 0;

        await getTallas(idProd).then((value) async{
          for (var i in value) {
            if (i['idTalla'] == idTalla) {
              int stock = i['cantidad'];
              nuevoT = stock + cant;

              await _db.collection('productos').doc(idProd).collection('talla').doc(i['idTalla']).update({
                'cantidad': nuevoT,
                'idTalla': i['idTalla'],
                'talla': i['talla']
              });
            }
          }
        });
      }
  }
}

Future<void> deleteElementShoppingCartId(String idU, String idES) async{
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