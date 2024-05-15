class Geocoding {
  final bool error;
  final int codeError;
  final dynamic errorMessage;
  final Response response;

  Geocoding({
    required this.error,
    required this.codeError,
    required this.errorMessage,
    required this.response,
  });

  factory Geocoding.fromJson(Map<String, dynamic> json) => Geocoding(
        error: json["error"],
        codeError: json["code_error"],
        errorMessage: json["error_message"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "code_error": codeError,
        "error_message": errorMessage,
        "response": response.toJson(),
      };
}

class Response {
  final String cp;
  final dynamic calle;
  final dynamic numero;
  final List<String> asentamiento;
  final String tipoAsentamiento;
  final String municipio;
  final String estado;
  final String ciudad;
  final String pais;
  final List<GeocodingElement> geocoding;

  Response({
    required this.cp,
    required this.calle,
    required this.numero,
    required this.asentamiento,
    required this.tipoAsentamiento,
    required this.municipio,
    required this.estado,
    required this.ciudad,
    required this.pais,
    required this.geocoding,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        cp: json["cp"],
        calle: json["calle"],
        numero: json["numero"],
        asentamiento: List<String>.from(json["asentamiento"].map((x) => x)),
        tipoAsentamiento: json["tipo_asentamiento"],
        municipio: json["municipio"],
        estado: json["estado"],
        ciudad: json["ciudad"],
        pais: json["pais"],
        geocoding: List<GeocodingElement>.from(
            json["geocoding"].map((x) => GeocodingElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cp": cp,
        "calle": calle,
        "numero": numero,
        "asentamiento": List<dynamic>.from(asentamiento.map((x) => x)),
        "tipo_asentamiento": tipoAsentamiento,
        "municipio": municipio,
        "estado": estado,
        "ciudad": ciudad,
        "pais": pais,
        "geocoding": List<dynamic>.from(geocoding.map((x) => x.toJson())),
      };
}

class GeocodingElement {
  final dynamic lat;
  final dynamic lng;
  final dynamic label;

  GeocodingElement({
    required this.lat,
    required this.lng,
    required this.label,
  });

  factory GeocodingElement.fromJson(Map<String, dynamic> json) =>
      GeocodingElement(
        lat: json["lat"],
        lng: json["lng"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "label": label,
      };
}
