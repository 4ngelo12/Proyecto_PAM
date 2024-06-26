import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto/app/models/cliente/client_model.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final _user = _auth.currentUser;

Future<void> addCli(String nombre, String apellido, String telefono, String correo, String password) async {
  await _auth.createUserWithEmailAndPassword(
      email: correo,
      password: password
  );

  String? idCli = _auth.currentUser?.uid;
  ClienteModel cliente = ClienteModel(nombre: nombre, apellido: apellido, email: correo, telefono: telefono);

  await _db.collection('clientes').doc(idCli).set(cliente.toJson());

  _auth.signOut();
}

Future<List> getClientes() async{
  List lstClientes = [];
  CollectionReference collectionReferenceCli = _db.collection('clientes');
  QuerySnapshot queryCli = await collectionReferenceCli.get();

  for (var element in queryCli.docs) {
    lstClientes.add(element.data());
  }

  return lstClientes;
}

Future<List> getClientesId(String id) async {
  List lstClientes = [];
  final docUser = await _db.collection('clientes').doc(id).get();

  lstClientes.add(docUser.data());

  return lstClientes;
}

Future<void> editData(String uId, String nombre, String apellido, String telefono, String correo) async{
  ClienteModel dataUser = ClienteModel(nombre: nombre, apellido: apellido, email: correo, telefono: telefono);
  final cliente = _db.collection('clientes').doc(uId);
  await cliente.update(dataUser.toJson());
  await _user?.updateEmail(correo);
}

void recoveryPassword(String mail) async {
  await _auth
      .sendPasswordResetEmail(email: mail);
}