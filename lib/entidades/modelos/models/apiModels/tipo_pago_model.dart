class TipoPagoModel {
  final String descripcion;
  final int idTipo;

  TipoPagoModel({
    required this.descripcion,
    required this.idTipo,
  });

  factory TipoPagoModel.fromJson(Map<String, dynamic> json) => TipoPagoModel(
        descripcion: json["descripcion"],
        idTipo: json["idTipo"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "idTipo": idTipo,
      };
}
