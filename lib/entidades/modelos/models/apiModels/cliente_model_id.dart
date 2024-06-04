import 'package:delibery_app/entidades/modelos/models/apiModels/cliente_model.dart';

class ClienteModelId extends ClienteModel {
  final int id;

  ClienteModelId({
    required this.id,
    required String nombre,
    required String fechaNacimiento,
    required String email,
    required String telefono,
    required String urlFoto,
    required int idGenero,
    required Direccion direccion,
    required String password,
  }) : super(
            direccion: direccion,
            email: email,
            fechaNacimiento: fechaNacimiento,
            idGenero: idGenero,
            nombre: nombre,
            password: password,
            telefono: telefono,
            urlFoto: urlFoto);

  factory ClienteModelId.fromJson(Map<String, dynamic> json) => ClienteModelId(
        id: json["id"],
        nombre: json["nombre"],
        fechaNacimiento: json["fechaNacimiento"],
        email: json["email"],
        telefono: json["telefono"],
        urlFoto: json["urlFoto"],
        idGenero: json["idGenero"],
        direccion: Direccion.fromJson(json["direccion"]),
        password: json["password"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "fechaNacimiento": fechaNacimiento,
        "email": email,
        "telefono": telefono,
        "urlFoto": urlFoto,
        "idGenero": idGenero,
        "direccion": direccion.toJson(),
        "password": password,
      };
}
