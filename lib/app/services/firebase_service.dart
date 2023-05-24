import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getProductos() async {
  List lstProducts = [];
  CollectionReference collectionReferenceProductos = db.collection('productos');
  QuerySnapshot queryProductos = await collectionReferenceProductos.get();

  queryProductos.docs.forEach((documento) {
    lstProducts.add(documento.data());
  });

  return lstProducts;
}
/*
Future<List> getProductos1() async {
  List lstProducts = [];
  CollectionReference collectionReferenceProductos = db.collection('productos').doc(idUser);
  QuerySnapshot queryProductos = await collectionReferenceProductos.get();

  queryProductos.docs.forEach((documento) {
    lstProducts.add(documento.data());
  });

  return lstProducts;
}
*/
