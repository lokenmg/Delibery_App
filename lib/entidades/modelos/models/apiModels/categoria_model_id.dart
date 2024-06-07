class CategoriaModelId {
  final int idCategoria;
  final String descripcion;

  CategoriaModelId({required this.idCategoria, required this.descripcion});

  factory CategoriaModelId.fromJson(Map<String, dynamic> json) {
    return CategoriaModelId(
      idCategoria: json['idCategoria'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategoria': idCategoria,
      'descripcion': descripcion,
    };
  }
}
