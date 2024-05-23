import 'package:delibery_app/modelos/models/apiModels/producto_model_id.dart';

class CarritoModel {
  ProductoModelId? producto;
  int? cantidad;
  double? subtotal;

  CarritoModel({this.producto, this.cantidad, this.subtotal});

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
