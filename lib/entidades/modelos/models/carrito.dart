import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model_id.dart';

class CarritoModel {
  ProductoModelId? producto;
  int cantidad = 0;
  int subtotal = 0;

  CarritoModel(
      {required this.producto, required this.cantidad, required this.subtotal});

  factory CarritoModel.fromJson(Map<String, dynamic> json) => CarritoModel(
        producto: ProductoModelId.fromJson(json["producto"]),
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
      );
  Map<String, dynamic> toJson() => {
        "producto": producto!.toJson(),
        "cantidad": cantidad,
        "subtotal": subtotal,
      };
}
