import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

Future<void> add(String nombre, String apellido, String telefono, String correo, String password) async {
  await auth.createUserWithEmailAndPassword(
      email: correo,
      password: password
  );

  String? idCli = auth.currentUser?.uid;

  print("general "+ idCli!);

  Map<String, dynamic> dataUser = {
    'nombre': nombre,
    'apellido': apellido,
    'telefono': telefono,
    'email': correo,
    'password': password,
  };

  db.collection('clientes').doc(idCli).set(dataUser);
  db.collection('clientes').doc(idCli).collection('favoritos').add({
    'idProd': '',
  });

  auth.signOut();
}

Future<List> getClientesId(String id) async {
  List lstClientes = [];
  final docUser = await db.collection('clientes').doc(id).get();

  lstClientes.add(docUser.data());
  print(lstClientes);

  return lstClientes;
}