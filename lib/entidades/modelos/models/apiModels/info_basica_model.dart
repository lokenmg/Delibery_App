class InfoBasicaModel {
  final String email;
  final String fechaNacimiento;
  final int idUsuario;
  final String nombre;
  final String telefono;
  String? urlFoto; // Hacer que urlFoto sea opcional

  InfoBasicaModel({
    required this.email,
    required this.fechaNacimiento,
    required this.idUsuario,
    required this.nombre,
    required this.telefono,
    this.urlFoto, // Marcar urlFoto como opcional en el constructor
  });

  factory InfoBasicaModel.fromJson(Map<String, dynamic> json) =>
      InfoBasicaModel(
        email: json["email"],
        fechaNacimiento: json["fechaNacimiento"],
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        urlFoto: json["urlFoto"] as String?, // Manejar null de forma segura
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "fechaNacimiento": fechaNacimiento,
        "idUsuario": idUsuario,
        "nombre": nombre,
        "telefono": telefono,
        "urlFoto": urlFoto, // Manejar null de forma segura
      };
}
