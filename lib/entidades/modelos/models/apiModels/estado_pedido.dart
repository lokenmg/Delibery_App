class EstadoPedidoModel {
  final String descripcion;
  final int idEstado;

  EstadoPedidoModel({
    required this.descripcion,
    required this.idEstado,
  });

  factory EstadoPedidoModel.fromJson(Map<String, dynamic> json) =>
      EstadoPedidoModel(
        descripcion: json["descripcion"],
        idEstado: json["idEstado"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "idEstado": idEstado,
      };
}
