class ProductoModel {
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagen;
  final List<int> categoriasId;
  final int idTienda;
  final double descuento;
  final int stock;

  ProductoModel({
    required this.categoriasId,
    required this.descripcion,
    required this.descuento,
    required this.idTienda,
    required this.imagen,
    required this.nombre,
    required this.precio,
    required this.stock,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        categoriasId: List<int>.from(json["categoriasId"].map((x) => x)),
        descripcion: json["descripcion"],
        descuento: json["descuento"],
        idTienda: json["idTienda"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
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
