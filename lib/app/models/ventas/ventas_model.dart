import 'dart:convert';

VentasModel ventasModelFromJson(String str) => VentasModel.fromJson(json.decode(str));

String ventasModelToJson(VentasModel data) => json.encode(data.toJson());

class VentasModel {
  String idVenta;
  String idUser;
  String fecha;
  double total;

  VentasModel({
    required this.idVenta,
    required this.idUser,
    required this.fecha,
    required this.total,
  });

  factory VentasModel.fromJson(Map<String, dynamic> json) => VentasModel(
    idVenta: json["idVenta"],
    idUser: json["idUser"],
    fecha: json["fecha"],
    total: json["total"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "idVenta": idVenta,
    "idUser": idUser,
    "fecha": fecha,
    "total": total,
  };
}
