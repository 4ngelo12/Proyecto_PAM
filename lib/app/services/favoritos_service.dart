import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

Future<void> addFavoriteProduct(String pId, String uId) async{
  List lstCli = [];

  final docCli = await _db.collection('clientes').doc(uId).
  collection('favoritos').get();

  for (var element in docCli.docs) {
    lstCli.add(element.data());
  }

  if (lstCli.isNotEmpty) {
    for (var element in lstCli) {
      if (element['idProd'] != pId) {
        await _db.collection('clientes').doc(uId).
        collection('favoritos').add({
          'idProd': pId,
        });
        break;
      }
    }
  } else {
    await _db.collection('clientes').doc(uId).
    collection('favoritos').add({
      'idProd': pId,
    });
  }
}

Future<void> deleteFavoriteProduct(String pId, String uId) async {
  List lstCli = [];

  final docCli = await _db.collection('clientes').doc(uId).
  collection('favoritos').get();

  for (var e in docCli.docs) {
    final Map<String, dynamic> data = e.data();
    final favoritos = {
      'idProd': data['idProd'],
      'fid': e.id
    };
    lstCli.add(favoritos);
  }

  for (var element in lstCli) {
    if (element['idProd'] == pId) {
      await _db.collection('clientes').doc(uId).
      collection('favoritos').doc(element['fid']).delete();
    }
  }
}
Future<bool> isFavorite(String pId, String uId) async {
  return await _db.collection('clientes').doc(uId).collection('favoritos').
  where('idProd', isEqualTo: pId).get().then((querySnapshot) {
    if (querySnapshot.size > 0) {
      return true;
    } else {
      return false;
    }
  });
}

Future<List> getFavortiosId(String uId) async{
  List lstClientes = [];
  final docCli = await _db.collection('clientes').doc(uId).
  collection('favoritos').get();

  for (var e in docCli.docs) {
    final Map<String, dynamic> data = e.data();
    lstClientes.add(data['idProd']);
  }

  return lstClientes;
}