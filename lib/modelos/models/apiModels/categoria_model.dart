class CategoriaModel {
  final String descripcion;

  CategoriaModel({
    required this.descripcion,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
      };
}
