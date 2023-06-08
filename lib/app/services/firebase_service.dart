import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getProductos() async {
  List lstProducts = [];
  CollectionReference collectionReferenceProductos = db.collection('productos');
  QuerySnapshot queryProductos = await collectionReferenceProductos.get();

  for (var documento in queryProductos.docs) {
    lstProducts.add(documento.data());
  }

  return lstProducts;
}

Future<List> getProductoId(String pId) async {
  List lstProducts = [];
  final producto = await db.collection('productos').doc(pId).get();

  lstProducts.add(producto.data());

  return lstProducts;
}

Future<List> getTallas(String pId) async{
  List lstTallas = [];

  final tallas = await db.collection('productos').doc(pId).collection('talla').get();

  for (var documento in tallas.docs) {
    lstTallas.add(documento.data());
  }

  return lstTallas;
}
