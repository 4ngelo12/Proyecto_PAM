import 'dart:convert';

ShoppingCartModel shoppingCartModelFromJson(String str) => ShoppingCartModel.fromJson(json.decode(str));

String shoppingCartModelToJson(ShoppingCartModel data) => json.encode(data.toJson());

class ShoppingCartModel {
  String id;
  String idProd;
  String idTalla;
  String nombre;
  double precio;
  int talla;
  int cantidad;
  String img;

  ShoppingCartModel({
    required this.id,
    required this.idProd,
    required this.idTalla,
    required this.nombre,
    required this.precio,
    required this.talla,
    required this.cantidad,
    required this.img,
  });

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) => ShoppingCartModel(
    id: json["id"],
    idProd: json["idProd"],
    idTalla: json["idTalla"],
    nombre: json["nombre"],
    precio: json["precio"]?.toDouble(),
    talla: json["talla"],
    cantidad: json["cantidad"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idProd": idProd,
    "idTalla": idTalla,
    "nombre": nombre,
    "precio": precio,
    "talla": talla,
    "cantidad": cantidad,
    "img": img,
  };
}
