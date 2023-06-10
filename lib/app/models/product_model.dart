import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {
        required this.name,
        required this.price,
        required this.cant,
        required this.image,
});

  String name;
  double price;
  int cant;
  String image;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    name: json["nombre"],
    image: json["imagen"],
    price: double.parse(json["precio"].toString()),
    cant: int.parse(json['cantidad'].toString()),
  );

  Map<String, dynamic> toJson() => {
    "nombre": name,
    "imagen": image,
    "precio": price,
    "cantidad": cant
  };

}