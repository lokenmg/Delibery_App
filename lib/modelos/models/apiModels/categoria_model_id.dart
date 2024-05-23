import 'package:delibery_app/modelos/models/apiModels/categoria_model.dart';

class CategoriaModelId extends CategoriaModel {
  final int id;

  CategoriaModelId({
    required this.id,
    required String descripcion,
  }) : super(descripcion: descripcion);

  factory CategoriaModelId.fromJson(Map<String, dynamic> json) =>
      CategoriaModelId(
        id: json["id"],
        descripcion: json["descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };
}
