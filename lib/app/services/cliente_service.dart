import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final _user = _auth.currentUser;

Future<void> addCli(String nombre, String apellido, String telefono, String correo, String password) async {
  await _auth.createUserWithEmailAndPassword(
      email: correo,
      password: password
  );

  String? idCli = _auth.currentUser?.uid;

  Map<String, dynamic> dataUser = {
    'apellido': apellido,
    'email': correo,
    'nombre': nombre,
    'telefono': telefono,
  };

  await db.collection('clientes').doc(idCli).set(dataUser);
  await db.collection('clientes').doc(idCli).collection('favoritos').add({
    'idProd': '',
  });

  _auth.signOut();
}

Future<List> getClientes() async{
  List lstClientes = [];
  CollectionReference collectionReferenceCli = db.collection('clientes');
  QuerySnapshot queryCli = await collectionReferenceCli.get();

  for (var element in queryCli.docs) {
    lstClientes.add(element.data());
  }

  return lstClientes;
}

Future<List> getClientesId(String id) async {
  List lstClientes = [];
  final docUser = await db.collection('clientes').doc(id).get();

  lstClientes.add(docUser.data());

  return lstClientes;
}

Future<void> editData(String uId, String nombre, String apellido, String telefono, String correo) async{

  Map<String, dynamic> dataUser = {
    'nombre': nombre,
    'apellido': apellido,
    'telefono': telefono,
    'email': correo,
  };

  final cliente = db.collection('clientes').doc(uId);
  await cliente.update(dataUser);
  await _user?.updateEmail(correo);
}

Future<void> addFavoriteProduct(String pId, String uId) async{
  List lstCli = [];

  final docCli = await db.collection('clientes').doc(uId).
  collection('favoritos').get();

  for (var element in docCli.docs) {
    lstCli.add(element.data());
  }

  if (lstCli.isNotEmpty) {
    for (var element in lstCli) {
      if (element['idProd'] != pId) {
        await db.collection('clientes').doc(uId).
        collection('favoritos').add({
          'idProd': pId,
        });
        break;
      }
    }
  } else {
    await db.collection('clientes').doc(uId).
    collection('favoritos').add({
      'idProd': pId,
    });
  }
}

Future<void> deleteFavoriteProduct(String pId, String uId) async {
  List lstCli = [];

  final docCli = await db.collection('clientes').doc(uId).
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
        await db.collection('clientes').doc(uId).
        collection('favoritos').doc(element['fid']).delete();
      }
    }
}

Future<bool> isFavorite(String pId, String uId) async {
    return await db.collection('clientes').doc(uId).collection('favoritos').
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
  final docCli = await db.collection('clientes').doc(uId).
  collection('favoritos').get();

  for (var e in docCli.docs) {
    final Map<String, dynamic> data = e.data();
    lstClientes.add(data['idProd']);
  }

  return lstClientes;
}

void recoveryPassword(String mail) async {
  await _auth
      .sendPasswordResetEmail(email: mail);
}