class TiendaModel {
  final double calificacion;
  final String descripcion;
  final Direccion direccion;
  final String email;
  final String horarios;
  final String nombre;
  final String telefono;

  TiendaModel({
    required this.calificacion,
    required this.descripcion,
    required this.direccion,
    required this.email,
    required this.horarios,
    required this.nombre,
    required this.telefono,
  });

  factory TiendaModel.fromJson(Map<String, dynamic> json) => TiendaModel(
        calificacion: json["calificacion"],
        descripcion: json["descripcion"],
        direccion: Direccion.fromJson(json["direccion"]),
        email: json["email"],
        horarios: json["horarios"],
        nombre: json["nombre"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toJson() => {
        "calificacion": calificacion,
        "descripcion": descripcion,
        "direccion": direccion.toJson(),
        "email": email,
        "horarios": horarios,
        "nombre": nombre,
        "telefono": telefono,
      };
}

class Direccion {
  final String calle1;
  final String calle2;
  final String calle3;
  final String colonia;
  final int cp;
  final String estado;
  final String municipio;
  final String numeroExterior;
  final String numeroInterior;
  final String referencia;

  Direccion({
    required this.calle1,
    required this.calle2,
    required this.calle3,
    required this.colonia,
    required this.cp,
    required this.estado,
    required this.municipio,
    required this.numeroExterior,
    required this.numeroInterior,
    required this.referencia,
  });

  factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        calle1: json["calle1"],
        calle2: json["calle2"],
        calle3: json["calle3"],
        colonia: json["colonia"],
        cp: json["cp"],
        estado: json["estado"],
        municipio: json["municipio"],
        numeroExterior: json["numeroExterior"],
        numeroInterior: json["numeroInterior"],
        referencia: json["referencia"],
      );

  Map<String, dynamic> toJson() => {
        "calle1": calle1,
        "calle2": calle2,
        "calle3": calle3,
        "colonia": colonia,
        "cp": cp,
        "estado": estado,
        "municipio": municipio,
        "numeroExterior": numeroExterior,
        "numeroInterior": numeroInterior,
        "referencia": referencia,
      };
}
