import 'package:delibery_app/entidades/modelos/models/apiModels/tienda_model.dart';

class TiendaModelId extends TiendaModel {
  final int id;

  TiendaModelId({
    required this.id,
    required int calificacion,
    required String descripcion,
    required Direccion direccion,
    required String email,
    required String horarios,
    required String nombre,
    required String telefono,
  }) : super(
          calificacion: calificacion,
          descripcion: descripcion,
          direccion: direccion,
          email: email,
          horarios: horarios,
          nombre: nombre,
          telefono: telefono,
        );

  factory TiendaModelId.fromJson(Map<String, dynamic> json) {
    return TiendaModelId(
      id: json["id"],
      calificacion: json["calificacion"],
      descripcion: json["descripcion"],
      direccion: Direccion.fromJson(json["direccion"]),
      email: json["email"],
      horarios: json["horarios"],
      nombre: json["nombre"],
      telefono: json["telefono"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "calificacion": calificacion,
        "descripcion": descripcion,
        "direccion": direccion.toJson(),
        "email": email,
        "horarios": horarios,
        "nombre": nombre,
        "telefono": telefono,
      };
}
