import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model.dart';

class ProductoModelId extends ProductoModel {
  final int id;

  ProductoModelId({
    required this.id,
    required List<int> categoriasId,
    required String descripcion,
    required int descuento,
    required int idTienda,
    required String imagen,
    required String nombre,
    required int precio,
    required int stock,
  }) : super(
          categoriasId: categoriasId,
          descripcion: descripcion,
          descuento: descuento,
          idTienda: idTienda,
          imagen: imagen,
          nombre: nombre,
          precio: precio,
          stock: stock,
        );

  factory ProductoModelId.fromJson(Map<String, dynamic> json) {
    return ProductoModelId(
      id: json["id"],
      categoriasId: List<int>.from(json["categoriasId"].map((x) => x)),
      descripcion: json["descripcion"],
      descuento: json["descuento"],
      idTienda: json["idTienda"],
      imagen: json["imagen"],
      nombre: json["nombre"],
      precio: json["precio"],
      stock: json["stock"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "categoriasId": List<dynamic>.from(categoriasId.map((x) => x)),
        "descripcion": descripcion,
        "descuento": descuento,
        "idTienda": idTienda,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
        "stock": stock,
      };
}
