import 'package:cloud_firestore/cloud_firestore.dart';
import 'carritocompras_service.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

Future<void> crearVenta(String uId, double tPrice, String fecha) async {
  await _db.collection('ventas').add({
    'idUser': uId,
  }).then((DocumentReference doc) async{
    await _db.collection('ventas').doc(doc.id).set({
      'idVenta': doc.id,
      'idUser': uId,
      'total': tPrice,
      'fecha': fecha
    });

    await _db.collection('ventas').doc(doc.id).get().then((value) async{
      getShoppingCart(uId).then((value) async{
        for (var i in value) {
          await _db.collection('clientes').doc(uId).collection('det_venta').add({
            'idVenta': doc.id,
            'idProd': i['idProd'],
            'idTalla': i['idTalla'],
            'nombre': i['nombre'],
            'precio': i['precio'],
            'talla': i['talla'],
            'cantidad': i['cantidad'],
            'img': i['img'],
          });

          deleteElementShoppingCartId(uId, i['id']);
        }
      });
    });
  });
}

Future<List> getDetVenta(String uId) async {
  final List lstDetVenta = [];
  
  final docDetV = await _db.collection('clientes').doc(uId).collection('det_venta').get();

  for (var i in docDetV.docs) {
    lstDetVenta.add(i);
  }
  
  return lstDetVenta;
}