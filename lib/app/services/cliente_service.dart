import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> add(String nombre, String apellido, String telefono, String correo, String password) async {
  await db.collection('clientes').add({
    'nombre': nombre,
    'apellido': apellido,
    'telefono': telefono,
    'email': correo,
    'password': password,
    'favoritos' :{
      'id': ''
    }
  });
}