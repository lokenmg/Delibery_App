class ClienteModel {
  final String nombre;
  final String fechaNacimiento;
  final String email;
  final String telefono;
  final String urlFoto;
  final int idGenero;
  final Direccion direccion;
  final String password;

  ClienteModel({
    required this.nombre,
    required this.fechaNacimiento,
    required this.email,
    required this.telefono,
    required this.urlFoto,
    required this.idGenero,
    required this.direccion,
    required this.password,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        nombre: json["nombre"],
        fechaNacimiento: json["fechaNacimiento"],
        email: json["email"],
        telefono: json["telefono"],
        urlFoto: json["urlFoto"],
        idGenero: json["idGenero"],
        direccion: Direccion.fromJson(json["direccion"]),
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
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

class Direccion {
  final int cp;
  final String estado;
  final String municipio;
  final String colonia;
  final String calle1;
  final String calle2;
  final String calle3;
  final String referencia;
  final int numeroExterior;
  final int numeroInterior;

  Direccion({
    required this.cp,
    required this.estado,
    required this.municipio,
    required this.colonia,
    required this.calle1,
    required this.calle2,
    required this.calle3,
    required this.referencia,
    required this.numeroExterior,
    required this.numeroInterior,
  });

  factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        cp: json["cp"],
        estado: json["estado"],
        municipio: json["municipio"],
        colonia: json["colonia"],
        calle1: json["calle1"],
        calle2: json["calle2"],
        calle3: json["calle3"],
        referencia: json["referencia"],
        numeroExterior: json["numero_exterior"],
        numeroInterior: json["numero_interior"],
      );

  Map<String, dynamic> toJson() => {
        "cp": cp,
        "estado": estado,
        "municipio": municipio,
        "colonia": colonia,
        "calle1": calle1,
        "calle2": calle2,
        "calle3": calle3,
        "referencia": referencia,
        "numero_exterior": numeroExterior,
        "numero_interior": numeroInterior,
      };
}
