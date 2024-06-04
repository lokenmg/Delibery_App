import 'package:delibery_app/entidades/modelos/models/apiModels/encargado_model.dart';

class EncargadoModelId extends EncargadoModel {
  final int id;

  EncargadoModelId({
    required this.id,
    required String antecedentes,
    required String curp,
    required Direccion direccion,
    required String email,
    required String fechaNacimiento,
    required int idGenero,
    required String ine,
    required String nombre,
    required String password,
    required String telefono,
    required String urlFoto,
  }) : super(
          antecedentes: antecedentes,
          curp: curp,
          direccion: direccion,
          email: email,
          fechaNacimiento: fechaNacimiento,
          idGenero: idGenero,
          ine: ine,
          nombre: nombre,
          password: password,
          telefono: telefono,
          urlFoto: urlFoto,
        );

  factory EncargadoModelId.fromJson(Map<String, dynamic> json) =>
      EncargadoModelId(
        id: json["id"],
        antecedentes: json["antecedentes"],
        curp: json["curp"],
        direccion: Direccion.fromJson(json["direccion"]),
        email: json["email"],
        fechaNacimiento: json["fechaNacimiento"],
        idGenero: json["idGenero"],
        ine: json["ine"],
        nombre: json["nombre"],
        password: json["password"],
        telefono: json["telefono"],
        urlFoto: json["urlFoto"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "antecedentes": antecedentes,
        "curp": curp,
        "direccion": direccion.toJson(),
        "email": email,
        "fechaNacimiento": fechaNacimiento,
        "idGenero": idGenero,
        "ine": ine,
        "nombre": nombre,
        "password": password,
        "telefono": telefono,
        "urlFoto": urlFoto,
      };
}
