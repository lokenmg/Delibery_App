class VentaModel {
  final List<Detalle> detalles;
  final String fechaCreacion;
  final int idCliente;
  final int idEstadoPago;
  final int idEstadoPedido;
  final int idRepartidor;
  final int idTipoPago;

  VentaModel({
    required this.detalles,
    required this.fechaCreacion,
    required this.idCliente,
    required this.idEstadoPago,
    required this.idEstadoPedido,
    required this.idRepartidor,
    required this.idTipoPago,
  });

  factory VentaModel.fromJson(Map<String, dynamic> json) => VentaModel(
        detalles: List<Detalle>.from(
            json["detalles"].map((x) => Detalle.fromJson(x))),
        fechaCreacion: json["fechaCreacion"],
        idCliente: json["idCliente"],
        idEstadoPago: json["idEstadoPago"],
        idEstadoPedido: json["idEstadoPedido"],
        idRepartidor: json["idRepartidor"],
        idTipoPago: json["idTipoPago"],
      );

  Map<String, dynamic> toJson() => {
        "detalles": List<dynamic>.from(detalles.map((x) => x.toJson())),
        "fechaCreacion": fechaCreacion,
        "idCliente": idCliente,
        "idEstadoPago": idEstadoPago,
        "idEstadoPedido": idEstadoPedido,
        "idRepartidor": idRepartidor,
        "idTipoPago": idTipoPago,
      };
}

class Detalle {
  final int cantidad;
  final int idProducto;

  Detalle({
    required this.cantidad,
    required this.idProducto,
  });

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        cantidad: json["cantidad"],
        idProducto: json["idProducto"],
      );

  Map<String, dynamic> toJson() => {
        "cantidad": cantidad,
        "idProducto": idProducto,
      };
}
