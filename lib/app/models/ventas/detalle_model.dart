import 'dart:convert';

DetalleVentasModel detalleVentasModelFromJson(String str) => DetalleVentasModel.fromJson(json.decode(str));

String detalleVentasModelToJson(DetalleVentasModel data) => json.encode(data.toJson());

class DetalleVentasModel {
  String idVenta;
  String idProd;
  String idTalla;
  String nombre;
  double precio;
  int talla;
  int cantidad;
  String img;

  DetalleVentasModel({
    required this.idVenta,
    required this.idProd,
    required this.idTalla,
    required this.nombre,
    required this.precio,
    required this.talla,
    required this.cantidad,
    required this.img,
  });

  factory DetalleVentasModel.fromJson(Map<String, dynamic> json) => DetalleVentasModel(
    idVenta: json["idVenta"],
    idProd: json["idProd"],
    idTalla: json["idTalla"],
    nombre: json["nombre"],
    precio: json["precio"]?.toDouble(),
    talla: json["talla"],
    cantidad: json["cantidad"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "idVenta": idVenta,
    "idProd": idProd,
    "idTalla": idTalla,
    "nombre": nombre,
    "precio": precio,
    "talla": talla,
    "cantidad": cantidad,
    "img": img,
  };
}
