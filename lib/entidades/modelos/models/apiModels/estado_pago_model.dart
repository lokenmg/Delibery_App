class EstadoPagoModel {
  final int idEstado;
  final String descripcion;

  EstadoPagoModel({
    required this.idEstado,
    required this.descripcion,
  });

  factory EstadoPagoModel.fromJson(Map<String, dynamic> json) =>
      EstadoPagoModel(
        idEstado: json["idEstado"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "idEstado": idEstado,
        "descripcion": descripcion,
      };
}
