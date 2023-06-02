import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
final user = auth.currentUser;

Future<void> addCli(String nombre, String apellido, String telefono, String correo, String password) async {
  await auth.createUserWithEmailAndPassword(
      email: correo,
      password: password
  );

  String? idCli = auth.currentUser?.uid;

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

  auth.signOut();
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
  await cliente.set(dataUser);
  await user?.updateEmail(correo);
}

void recoveryPassword(String mail) async {
  await auth
      .sendPasswordResetEmail(email: mail);
}