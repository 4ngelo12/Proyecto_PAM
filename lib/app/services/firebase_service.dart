import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final ImagePicker _picker = ImagePicker();
final FirebaseStorage _stg = FirebaseStorage.instance;

Future<XFile?> getImage () async{
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<bool> uploadImg(File image, String nombre, double precio, String desc) async {
  final ruta = image.path.split("/").last;
  Map<String, dynamic> dataPrdo = {
    'nombre': nombre,
  };

  final Reference ref = _stg.ref().child('productos').child(ruta);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL();
  print(url);

  await db.collection('productos').add(dataPrdo).then((DocumentReference doc) async {
    await db.collection('productos').doc(doc.id).set({
      'descripcion': desc,
      'idProd' : doc.id,
      'imagen': url,
      'nombre': nombre,
      'precio': precio
    });

    db.collection('productos').doc(doc.id).collection('talla').add({
      'cantidad': 90,
      'talla': 38
    });

    db.collection('productos').doc(doc.id).collection('talla').add({
      'cantidad': 50,
      'talla': 39
    });

    db.collection('productos').doc(doc.id).collection('talla').add({
      'cantidad': 35,
      'talla': 40
    });

    db.collection('productos').doc(doc.id).collection('talla').add({
      'cantidad': 20,
      'talla': 41
    });

    db.collection('productos').doc(doc.id).collection('talla').add({
      'cantidad': 35,
      'talla': 42
    });
  });
  if (snapshot.state == TaskState.success) {
    return true;
  }
  else {
    return false;
  }
}

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
