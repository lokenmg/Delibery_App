import 'package:delibery_app/entidades/modelos/geocidong_model.dart';
import 'package:dio/dio.dart';

class PeticionesCopomex {
  final String _urlBase = 'https://api.copomex.com/query/';
  final String _token = "73f3ef9b-242c-4f8b-a662-4587e8bc9ff8";

  final dio = Dio();
  Future<Geocoding> getCpGeoEncoding(String codigoPostal) async {
    Geocoding? resultado;
    final response = await dio.get(
        "${_urlBase}info_cp_geocoding/$codigoPostal?type=simplified&token=$_token");
    resultado = Geocoding.fromJson(response.data);
    return resultado;
  }
}
