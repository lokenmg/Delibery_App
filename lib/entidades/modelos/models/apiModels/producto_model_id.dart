import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model.dart';

class ProductoModelId extends ProductoModel {
  final int id;

  ProductoModelId({
    required this.id,
    required List<int> categoriasId,
    required String descripcion,
    required double descuento,
    required int idTienda,
    required String imagen,
    required String nombre,
    required double precio,
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
      id: json["idProducto"] ?? 0,
      categoriasId: (json["categorias"] as List<dynamic>)
          .map((categoria) => categoria["idCategoria"] as int)
          .toList(),
      descripcion: json["descripcion"] ?? '',
      descuento: json["descuento"] ?? 0,
      idTienda: json["idTienda"] ?? 0,
      imagen: json["imagen"] ?? '',
      nombre: json["nombre"] ?? '',
      precio: json["precio"] ?? 0,
      stock: json["stock"] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "idProducto": id,
        "categorias": categoriasId.map((x) => {"idCategoria": x}).toList(),
        "descripcion": descripcion,
        "descuento": descuento,
        "idTienda": idTienda,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
        "stock": stock,
      };
}
