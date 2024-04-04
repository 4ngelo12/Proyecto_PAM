import 'dart:convert';

ClienteModel clienteFromJson(String str) => ClienteModel.fromJson(json.decode(str));

String clienteToJson(ClienteModel data) => json.encode(data.toJson());

class ClienteModel {
  String nombre;
  String apellido;
  String email;
  String telefono;

  ClienteModel({
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
    nombre: json["nombre"],
    apellido: json["apellido"],
    email: json["email"],
    telefono: json["telefono"],
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "apellido": apellido,
    "email": email,
    "telefono": telefono,
  };
}
