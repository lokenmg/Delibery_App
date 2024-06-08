class VentaCompletaModel {
  final List<Detalle> detalles;
  final String fechaCreacion;
  final int idCliente;
  final int idEstadoPago;
  final int idEstadoPedido;
  final int idRepartidor;
  final int idTipoPago;
  final int idVenta;

  VentaCompletaModel({
    required this.detalles,
    required this.fechaCreacion,
    required this.idCliente,
    required this.idEstadoPago,
    required this.idEstadoPedido,
    required this.idRepartidor,
    required this.idTipoPago,
    required this.idVenta,
  });

  factory VentaCompletaModel.fromJson(Map<String, dynamic> json) =>
      VentaCompletaModel(
        detalles: List<Detalle>.from(
            json["detalles"].map((x) => Detalle.fromJson(x))),
        fechaCreacion: json["fechaCreacion"],
        idCliente: json["idCliente"],
        idEstadoPago: json["idEstadoPago"],
        idEstadoPedido: json["idEstadoPedido"],
        idRepartidor: json["idRepartidor"],
        idTipoPago: json["idTipoPago"],
        idVenta: json["idVenta"],
      );

  Map<String, dynamic> toJson() => {
        "detalles": List<dynamic>.from(detalles.map((x) => x.toJson())),
        "fechaCreacion": fechaCreacion,
        "idCliente": idCliente,
        "idEstadoPago": idEstadoPago,
        "idEstadoPedido": idEstadoPedido,
        "idRepartidor": idRepartidor,
        "idTipoPago": idTipoPago,
        "idVenta": idVenta,
      };
}

class Detalle {
  final int cantidad;
  final String descripcion;
  final int descuento;
  final int idDetalleVenta;
  final int idProducto;
  final int idVenta;
  final String imagen;
  final String nombre;
  final int precio;

  Detalle({
    required this.cantidad,
    required this.descripcion,
    required this.descuento,
    required this.idDetalleVenta,
    required this.idProducto,
    required this.idVenta,
    required this.imagen,
    required this.nombre,
    required this.precio,
  });

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        cantidad: json["cantidad"],
        descripcion: json["descripcion"],
        descuento: json["descuento"],
        idDetalleVenta: json["idDetalleVenta"],
        idProducto: json["idProducto"],
        idVenta: json["idVenta"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"],
      );

  Map<String, dynamic> toJson() => {
        "cantidad": cantidad,
        "descripcion": descripcion,
        "descuento": descuento,
        "idDetalleVenta": idDetalleVenta,
        "idProducto": idProducto,
        "idVenta": idVenta,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
      };
}
