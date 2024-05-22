class RepartidorModel {
  final String antecedentes;
  final String curp;
  final Direccion direccion;
  final String email;
  final String fechaNacimiento;
  final int idGenero;
  final String ine;
  final String licencia;
  final String nombre;
  final String password;
  final String telefono;
  final Vehiculo vehiculo;

  RepartidorModel({
    required this.antecedentes,
    required this.curp,
    required this.direccion,
    required this.email,
    required this.fechaNacimiento,
    required this.idGenero,
    required this.ine,
    required this.licencia,
    required this.nombre,
    required this.password,
    required this.telefono,
    required this.vehiculo,
  });

  factory RepartidorModel.fromJson(Map<String, dynamic> json) =>
      RepartidorModel(
        antecedentes: json["antecedentes"],
        curp: json["curp"],
        direccion: Direccion.fromJson(json["direccion"]),
        email: json["email"],
        fechaNacimiento: json["fechaNacimiento"],
        idGenero: json["idGenero"],
        ine: json["ine"],
        licencia: json["licencia"],
        nombre: json["nombre"],
        password: json["password"],
        telefono: json["telefono"],
        vehiculo: Vehiculo.fromJson(json["vehiculo"]),
      );

  Map<String, dynamic> toJson() => {
        "antecedentes": antecedentes,
        "curp": curp,
        "direccion": direccion.toJson(),
        "email": email,
        "fechaNacimiento": fechaNacimiento,
        "idGenero": idGenero,
        "ine": ine,
        "licencia": licencia,
        "nombre": nombre,
        "password": password,
        "telefono": telefono,
        "vehiculo": vehiculo.toJson(),
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

class Vehiculo {
  final String marca;
  final String modelo;
  final String niv;
  final String placa;
  final String repube;
  final String tipo;

  Vehiculo({
    required this.marca,
    required this.modelo,
    required this.niv,
    required this.placa,
    required this.repube,
    required this.tipo,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        marca: json["marca"],
        modelo: json["modelo"],
        niv: json["niv"],
        placa: json["placa"],
        repube: json["repube"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "marca": marca,
        "modelo": modelo,
        "niv": niv,
        "placa": placa,
        "repube": repube,
        "tipo": tipo,
      };
}
